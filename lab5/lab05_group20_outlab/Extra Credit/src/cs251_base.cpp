/*
* Copyright (c) 2006-2009 Erin Catto http://www.box2d.org
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

#include "cs251_base.hpp"

#ifndef __APPLE__
#include "GL/glui.h"
#else
#include "GL/glui.h"
#endif

#include <iostream>
#include <cstdio>
using namespace std;
using namespace cs251;


base_sim_t::base_sim_t()
{
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	m_world = new b2World(gravity);

	m_text_line = 30;

	m_point_count = 0;

	m_world->SetDebugDraw(&m_debug_draw);
	
	m_step_count = 0;

	b2BodyDef body_def;
	m_ground_body = m_world->CreateBody(&body_def);

	memset(&m_max_profile, 0, sizeof(b2Profile));
	memset(&m_total_profile, 0, sizeof(b2Profile));
}

base_sim_t::~base_sim_t()
{
	// By deleting the world, we delete the bomb, mouse joint, etc.
	delete m_world;
	m_world = NULL;
}

void base_sim_t::pre_solve(b2Contact* contact, const b2Manifold* oldManifold)
{

  const b2Manifold* manifold = contact->GetManifold();
  
  if (manifold->pointCount == 0)
    {
      return;
    }
  
  b2Fixture* fixtureA = contact->GetFixtureA();
  b2Fixture* fixtureB = contact->GetFixtureB();
  
  b2PointState state1[b2_maxManifoldPoints], state2[b2_maxManifoldPoints];
  b2GetPointStates(state1, state2, oldManifold, manifold);
  
  b2WorldManifold world_manifold;
  contact->GetWorldManifold(&world_manifold);
  
  for (int32 i = 0; i < manifold->pointCount && m_point_count < k_max_contact_points; ++i)
    {
      contact_point_t* cp = m_points + m_point_count;
      cp->fixtureA = fixtureA;
      cp->fixtureB = fixtureB;
      cp->position = world_manifold.points[i];
      cp->normal = world_manifold.normal;
      cp->state = state2[i];
      ++m_point_count;
    }
}

void base_sim_t::draw_title(int x, int y, const char *string)
{
    m_debug_draw.DrawString(x, y, string);
}

void base_sim_t::step(settings_t* settings)
{
  float32 time_step = settings->hz > 0.0f ? 1.0f / settings->hz : float32(0.0f);

	b2Body *list1;
	list1 = m_world->GetBodyList();
	while(list1->GetNext()){
		void* x = list1->GetUserData();
		if(*(int*)x==2){
		  b2Vec2 a,b;
		  a = list1->GetPosition();
		  b2Body* list2 = m_world->GetBodyList();
		  while(list2->GetNext()){
		  	void* y = list2->GetUserData();
		  	if(*(int*)y==1 || *(int*)y==0){
		  		b = list2->GetPosition();
		      	b2Vec2 c =  b-a;
		      	double k = c.LengthSquared();
		      	c *= (500.0/k);
		      	if(*(int*)y==0)	c *= -1;
		      	list1->ApplyForceToCenter(c,true);
		  	}
		  	list2=list2->GetNext();
		  }
		}
		else if(*(int*)x==4){
			b2Body* ball =  list1;
			srand (time(NULL));
	  		float32 z = rand() % 90 - 45;
			ball->SetTransform(b2Vec2(z,40.0f),0);
			*(int*)x=2;
			ball->SetUserData(x);
			
			z = rand() % 90 - 45;
			b2Body *b1;
			b2CircleShape shape;
			shape.m_radius = 1.0f;
			b2FixtureDef f;
			f.shape = &shape;
			f.friction = 0.0f;
			f.restitution = 0.7f;
			f.density = 1.0f;
			b2BodyDef bd;
			bd.type = b2_dynamicBody;
			bd.position.Set(z,40.0f);
			bd.userData = malloc(sizeof(int));
  			*(int*)(bd.userData) = 2;			
			b1 = m_world->CreateBody(&bd);
			b1->CreateFixture(&f);
		}
		list1 = list1->GetNext();
	}

  if (settings->pause)
    {
      if (settings->single_step)
	{
	  settings->single_step = 0;
	}
      else
	{
	  time_step = 0.0f;
	}
      
      m_debug_draw.DrawString(5, m_text_line, "****PAUSED****");
      m_text_line += 15;
    }
  
  uint32 flags = 0;
  flags += settings->draw_shapes			* b2Draw::e_shapeBit;
  flags += settings->draw_joints			* b2Draw::e_jointBit;
  flags += settings->draw_AABBs			* b2Draw::e_aabbBit;
  flags += settings->draw_pairs			* b2Draw::e_pairBit;
  flags += settings->draw_COMs				* b2Draw::e_centerOfMassBit;
  m_debug_draw.SetFlags(flags);
  
  m_world->SetWarmStarting(settings->enable_warm_starting > 0);
  m_world->SetContinuousPhysics(settings->enable_continuous > 0);
  m_world->SetSubStepping(settings->enable_sub_stepping > 0);
  
  m_point_count = 0;
  
  m_world->Step(time_step, settings->velocity_iterations, settings->position_iterations);
  
  m_world->DrawDebugData();
  
  if (time_step > 0.0f)
    {
      ++m_step_count;
    }
  
  if (settings->draw_stats)
    {
      int32 body_count = m_world->GetBodyCount();
      int32 contact_count = m_world->GetContactCount();
      int32 joint_count = m_world->GetJointCount();
      m_debug_draw.DrawString(5, m_text_line, "bodies/contacts/joints = %d/%d/%d", body_count, contact_count, joint_count);
      m_text_line += 15;
      
      int32 proxy_count = m_world->GetProxyCount();
      int32 height = m_world->GetTreeHeight();
      int32 balance = m_world->GetTreeBalance();
      float32 quality = m_world->GetTreeQuality();
      m_debug_draw.DrawString(5, m_text_line, "proxies/height/balance/quality = %d/%d/%d/%g", proxy_count, height, balance, quality);
      m_text_line += 15;
    }
  
  // Track maximum profile times
  {
    const b2Profile& p = m_world->GetProfile();
    m_max_profile.step = b2Max(m_max_profile.step, p.step);
    m_max_profile.collide = b2Max(m_max_profile.collide, p.collide);
    m_max_profile.solve = b2Max(m_max_profile.solve, p.solve);
    m_max_profile.solveInit = b2Max(m_max_profile.solveInit, p.solveInit);
    m_max_profile.solveVelocity = b2Max(m_max_profile.solveVelocity, p.solveVelocity);
    m_max_profile.solvePosition = b2Max(m_max_profile.solvePosition, p.solvePosition);
    m_max_profile.solveTOI = b2Max(m_max_profile.solveTOI, p.solveTOI);
    m_max_profile.broadphase = b2Max(m_max_profile.broadphase, p.broadphase);
    
    m_total_profile.step += p.step;
    m_total_profile.collide += p.collide;
    m_total_profile.solve += p.solve;
    m_total_profile.solveInit += p.solveInit;
    m_total_profile.solveVelocity += p.solveVelocity;
    m_total_profile.solvePosition += p.solvePosition;
    m_total_profile.solveTOI += p.solveTOI;
    m_total_profile.broadphase += p.broadphase;
  }
  
  if (settings->draw_profile)
    {
      const b2Profile& p = m_world->GetProfile();
      
      b2Profile ave_profile;
      memset(&ave_profile, 0, sizeof(b2Profile));
      if (m_step_count > 0)
	{
	  float32 scale = 1.0f / m_step_count;
	  ave_profile.step = scale * m_total_profile.step;
	  ave_profile.collide = scale * m_total_profile.collide;
	  ave_profile.solve = scale * m_total_profile.solve;
	  ave_profile.solveInit = scale * m_total_profile.solveInit;
	  ave_profile.solveVelocity = scale * m_total_profile.solveVelocity;
	  ave_profile.solvePosition = scale * m_total_profile.solvePosition;
	  ave_profile.solveTOI = scale * m_total_profile.solveTOI;
	  ave_profile.broadphase = scale * m_total_profile.broadphase;
	}
      
      m_debug_draw.DrawString(5, m_text_line, "step [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.step, ave_profile.step, m_max_profile.step);
      m_text_line += 15;
      m_debug_draw.DrawString(5, m_text_line, "collide [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.collide, ave_profile.collide, m_max_profile.collide);
      m_text_line += 15;
      m_debug_draw.DrawString(5, m_text_line, "solve [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.solve, ave_profile.solve, m_max_profile.solve);
      m_text_line += 15;
      m_debug_draw.DrawString(5, m_text_line, "solve init [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.solveInit, ave_profile.solveInit, m_max_profile.solveInit);
      m_text_line += 15;
      m_debug_draw.DrawString(5, m_text_line, "solve velocity [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.solveVelocity, ave_profile.solveVelocity, m_max_profile.solveVelocity);
      m_text_line += 15;
      m_debug_draw.DrawString(5, m_text_line, "solve position [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.solvePosition, ave_profile.solvePosition, m_max_profile.solvePosition);
      m_text_line += 15;
      m_debug_draw.DrawString(5, m_text_line, "solveTOI [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.solveTOI, ave_profile.solveTOI, m_max_profile.solveTOI);
      m_text_line += 15;
      m_debug_draw.DrawString(5, m_text_line, "broad-phase [ave] (max) = %5.2f [%6.2f] (%6.2f)", p.broadphase, ave_profile.broadphase, m_max_profile.broadphase);
      m_text_line += 15;
    }
    
  if (settings->draw_contact_points)
    {
      //const float32 k_impulseScale = 0.1f;
      const float32 k_axis_scale = 0.3f;
      
      for (int32 i = 0; i < m_point_count; ++i)
	{
	  contact_point_t* point = m_points + i;
	  
	  if (point->state == b2_addState)
	    {
	      // Add
	      m_debug_draw.DrawPoint(point->position, 10.0f, b2Color(0.3f, 0.95f, 0.3f));
	    }
	  else if (point->state == b2_persistState)
	    {
	      // Persist
	      m_debug_draw.DrawPoint(point->position, 5.0f, b2Color(0.3f, 0.3f, 0.95f));
	    }
	  
	  if (settings->draw_contact_normals == 1)
	    {
	      b2Vec2 p1 = point->position;
	      b2Vec2 p2 = p1 + k_axis_scale * point->normal;
	      m_debug_draw.DrawSegment(p1, p2, b2Color(0.9f, 0.9f, 0.9f));
	    }
	  else if (settings->draw_contact_forces == 1)
	    {
	      //b2Vec2 p1 = point->position;
	      //b2Vec2 p2 = p1 + k_forceScale * point->normalForce * point->normal;
	      //DrawSegment(p1, p2, b2Color(0.9f, 0.9f, 0.3f));
	    }
	  
	  if (settings->draw_friction_forces == 1)
	    {
	      //b2Vec2 tangent = b2Cross(point->normal, 1.0f);
	      //b2Vec2 p1 = point->position;
	      //b2Vec2 p2 = p1 + k_forceScale * point->tangentForce * tangent;
	      //DrawSegment(p1, p2, b2Color(0.9f, 0.9f, 0.3f));
	    }
	}
    }
}

void base_sim_t :: mouse_down(const b2Vec2& p){
	// std::cout<<1<<endl;
	b2Body* list;
	list = m_world->GetBodyList();
	while(list->GetNext()){
		void* x = list->GetUserData();
		if(*(int*)x==1 || *(int*)x==0){
			b2Fixture* f;
			f = list->GetFixtureList();
			if(f->TestPoint(p)){
				if(*(int*)x==1)	*(int*)x = 0;
				else 	*(int*)x = 1;
			}
		}
		list = list->GetNext();
	}
}

void base_sim_t :: keyboard(unsigned char key){
	b2Body* list;
	list = m_world->GetBodyList();
	while(list->GetNext()){
		void* x = list->GetUserData();
		if(*(int*)x==1 || *(int*)x==0){
			if(key=='q')
				*(int*)x=1;
			else if(key=='t')
				*(int*)x=(*(int*)x + 1)%2;
		}
		else if(*(int*)x==3){
			switch(key){
				case GLUT_KEY_LEFT:{	
					b2Vec2 a = list->GetPosition();
					b2Vec2 b(2.0f,0.0f);
					list->SetTransform(a-b,0);
				}	
					break;
				case GLUT_KEY_RIGHT:{	
					b2Vec2 a = list->GetPosition();
					b2Vec2 b(2.0f,0.0f);
					list->SetTransform(a+b,0);
				}	
					break;
			}
		}
		list = list->GetNext();
	}
}

void MyContactListener :: BeginContact(b2Contact* contact){
	// std:: cout<<1<<endl;
	void* x = contact->GetFixtureA()->GetBody()->GetUserData();
	void* y = contact->GetFixtureB()->GetBody()->GetUserData();
	if(*(int*)x==2 || *(int*)y==2){
		if(*(int*)x==2){
			if(*(int*)y==3){
				*(int*)x=4;
				contact->GetFixtureA()->GetBody()->SetUserData(x);
			}
			if(*(int*)y==5){
				std::cout<<"GAME OVER"<<endl;
				exit(0);
			}
		}
		else{
			if(*(int*)x==3){
				*(int*)y=4;
				contact->GetFixtureB()->GetBody()->SetUserData(y);
			}
			if(*(int*)x==5){
				std::cout<<"GAME OVER"<<endl;	
				exit(0);
			}
		}
	}
}

void MyContactListener :: EndContact(b2Contact* contact){
	// std:: cout<<2<<endl;
	// void* x = contact->GetFixtureA()->GetBody()->GetUserData();
	// void* y = contact->GetFixtureA()->GetBody()->GetUserData();
	// std::cout<<*(int*)x<<"  "<<*(int*)y<<endl;
}

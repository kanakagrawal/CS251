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

/* 
 * Base code for CS 251 Software Systems Lab 
 * Department of Computer Science and Engineering, IIT Bombay
 * 
 */
 #include <ctime>

#include <iostream>
#include "cs251_base.hpp"
#include "render.hpp"

#ifdef __APPLE__
	#include <GLUT/glut.h>
#else
	#include "GL/freeglut.h"
#endif

#include <cstring>
using namespace std;

#include "dominos.hpp"

namespace cs251
{
  /**  The is the constructor 
   * This is the documentation block for the constructor.
   */ 



  class b2MagnetDef : public b2BodyDef{
  	public:
  	b2MagnetDef(){
  		userData = malloc(sizeof(int));
  		*(int*)(userData) = 0;			//0 implies repulsive magnet
  	}
  	b2MagnetDef(float32 x, float32 y){
  		userData = malloc(sizeof(int));
  		*(int*)(userData) = 0;			//0 implies repulsive magnet
  		position.Set(x,y);
  	}
  };

  class b2MetalDef : public b2BodyDef{
  public:
  	b2MetalDef(){
  		userData = malloc(sizeof(int));
  		*(int*)(userData) = 2;			//2 implies metallic
  		type = b2_dynamicBody;
  	}
  	b2MetalDef(float32 x, float32 y){
  		userData = malloc(sizeof(int));
  		*(int*)(userData) = 2;			//2 implies metallic
  		type = b2_dynamicBody;
  		position.Set(x,y);
  	}
  };

  class b2DefaultBodyDef : public b2BodyDef{
  public:
  	b2DefaultBodyDef(){
  		userData = malloc(sizeof(int));
  		*(int*)(userData) = -1;			//-1 implies neither metal nor magnet
  	}
  	b2DefaultBodyDef(float32 x, float32 y){
  		userData = malloc(sizeof(int));
  		*(int*)(userData) = -1;			//-1 implies neither metal nor magnet
  		position.Set(x,y);
  	}
  };

  void dominos_t :: createMetalBall(){
	  b2Body *b1;
	  b2CircleShape shape;
	  shape.m_radius = 1.0f;
	  b2FixtureDef f;
	  f.shape = &shape;
	  f.friction = 0.0f;
	  f.restitution = 0.7f;
	  f.density = 1.0f;
	  srand (time(NULL));
	  float32 x = rand() % 90 - 45;
	  b2MetalDef bd(x,40.0f);
	  b1 = m_world->CreateBody(&bd);
	  b1->CreateFixture(&f);
  }


  dominos_t::dominos_t()
  {
    // m_world->SetGravity(b2Vec2(0.0f,0.0f));
    

    //Creating ground and other boundaries so that ball doenot escape
    {
      b2Body *b1,*b2,*b3,*b4;
      b2PolygonShape shape1,shape2;
      shape1.SetAsBox(100.0f,0.05f);
      shape2.SetAsBox(0.05f,100.0f);
      b2DefaultBodyDef bd1(0.0f,-5.0f),bd2(0.0f,43.0f),bd3(-45.0f,20.0f),bd4(45.0f,20.0f);
      bd1.userData = malloc(sizeof(int));
      *(int*)(bd1.userData) = 5;
      b1 = m_world->CreateBody(&bd1);
      b1->CreateFixture(&shape1,100.0f);
      b2 = m_world->CreateBody(&bd2);
      b2->CreateFixture(&shape1,100.0f);
      b3 = m_world->CreateBody(&bd3);
      b3->CreateFixture(&shape2,100.0f);
      b4 = m_world->CreateBody(&bd4);
      b4->CreateFixture(&shape2,100.0f);
    }

    ///Horizontal Slider
    {
    	b2Body* b1;
    	b2BodyDef bd;
    	bd.userData = malloc(sizeof(int));
    	*(int*)(bd.userData) = 3;					//3 implies slider
    	b2PolygonShape shape;
    	shape.SetAsBox(10.0f,0.5f);
    	bd.type = b2_dynamicBody;
    	bd.position.Set(0.0f,-4.0f);
    	b1 = m_world->CreateBody(&bd);
      	b1->CreateFixture(&shape,10.0f);
    }

    // Creating  magnet balls
    {
      b2Body *b1,*b2,*b3,*b4;
      b2CircleShape shape;
      shape.m_radius = 5.0f;
      b2FixtureDef f;
      f.shape = &shape;
      f.friction = 0.0f;
      b2MagnetDef bd1(-25.0f,30.0f),bd2(20.0f,35.0f),bd3(-30.0f,10.0f),bd4(25.0f,15.0f);
      b1 = m_world->CreateBody(&bd1);
      b1->CreateFixture(&f);
      b2 = m_world->CreateBody(&bd2);
      b2->CreateFixture(&f);
      b3 = m_world->CreateBody(&bd3);
      b3->CreateFixture(&f);
      b4 = m_world->CreateBody(&bd4);
      b4->CreateFixture(&f);
    }


    ///Creating a metal ball;
    {
      createMetalBall();
    }
    MyContactListener *a;
    a = new MyContactListener;
    m_world->SetContactListener(a);
  }

  sim_t *sim = new sim_t("Dominos", dominos_t::create);
}

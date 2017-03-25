/*
* Copyright (c) 2006-2007 Erin Catto http://www.box2d.org
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

/** 
 * Base code for CS 251 Software Systems Lab 
 * Department of Computer Science and Engineering, IIT Bombay
 * 
 */

#ifndef _RENDER_HPP_
#define _RENDER_HPP_

#include <Box2D/Box2D.h>

struct b2AABB;

/**
* This class implements debug drawing callbacks that are invoked
* inside b2World::Step.
 */
class debug_draw_t : public b2Draw
{
public:
	/**
	* Draws Polygon. Takes 3 arguments
	*/
  void DrawPolygon(const b2Vec2* vertices/**< is a pointer of center of polygon */, int32 vertexCount/**< is number of vertices in polygon */, const b2Color& color/**< is color of polygon */);
  	/**
	* Draws Soild Polygon. Takes 3 arguments
	*/
  void DrawSolidPolygon(const b2Vec2* vertices/**< is a pointer of center of polygon */, int32 vertexCount/**< is number of vertices in polygon */, const b2Color& color/**< is color of polygon */);
  	/**
	* Draws Circle. Takes 3 arguments
	*/
  void DrawCircle(const b2Vec2& center/**< is a vector storing center of circle */, float32 radius/**< is radius of circle */, const b2Color& color/**< is color of circle */);
  	/**
	* Draws Solid Circle. Takes 4 arguments
	*/
  void DrawSolidCircle(const b2Vec2& center/**< is a vector storing center of circle */, float32 radius/**< is radius of circle */, const b2Color& color/**< is color of circle */);
  	/**
	* Draws Segment. Takes 3 arguments
	*/

  void DrawSegment(const b2Vec2& p1/**< is start point of segment */, const b2Vec2& p2/**< is end point of segment */, const b2Color& color/**< is color of segment */);

  	/**
	* Draws Transform. Takes 1 arguments
	*/
  void DrawTransform(const b2Transform& xf/**< is a b2Transform call by reference*/);
  	/**
	* Draws Point. Takes 3 arguments
	*/
  void DrawPoint(const b2Vec2& p/**< is position of point */, float32 size/**< is size of point */, const b2Color& color/**< is color of point */);
  	/**
	* Draws String. Takes 3 arguments
	*/
  void DrawString(int x/**< is x cooridinate on screen where to write string*/, int y/**< is y cooridinate on screen where to write string*/, const char* string,/**< is string to show*/ ...); 
  	/**
	* Draws AABB. Takes 2 arguments
	*/
  void DrawAABB(b2AABB* aabb/**< is pointer of AABB*/, const b2Color& color/**< is color of AABB */);
};


#endif

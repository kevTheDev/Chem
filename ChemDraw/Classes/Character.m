//
//  Character.m
//  ChemDraw
//
//  Created by Kevin Edwards on 14/07/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "PointObject.h"
#import "CharacterMatch.h"

@implementation Character

int a[256] = {
	
		0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
		0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
		0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,
		0,0,0,0,1,1,1,0,0,1,1,1,0,0,0,0,
		0,0,0,0,1,1,1,0,0,1,1,1,0,0,0,0,
		0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,
		0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
		0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
		0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
		0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
		1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
		1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1		

				
	};
	
	int b[256] =

{
1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0
};

// C

int c[256] =
{
0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0
};
//

int d[256] =

{
1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0
};
//
//// E

int e[256] =

{
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
};

//// F

int f[256] =

{
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0
};
//
//// G

int g[256] =

{
0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0
};

// H
int h[256] =
{
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1
};

// I
int i[256] = 
{
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
};

// J
int j[256] ={
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,
0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,
0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,
0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,0,0,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,0,0,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,
0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0
};

// K
int k[256] =
{
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,0,1,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,0,1,1,1,1,1,1,0,0,0,0,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1
};

// L
int l[256] =
{
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
};

// M
int m[256] =
{
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
0,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,
1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,
1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1
};

// N

int n[256] =
{
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1
};
	
int o[256] =

{
0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,
0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,
0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,0,
0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,
0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0


};

// P

int p[256] =

{
1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0
};

// Q

int q[256] =

{
0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,1,1,1,1,1,0,0,1,1,1,1,1,0,0,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,1,1,0,1,1,1,1,1,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,
0,1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,
0,0,1,1,1,1,1,0,0,1,1,1,1,1,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,0,0,0,1,1,1,1,1,1,0,1,1,1,1,
0,0,0,0,0,0,1,1,1,1,0,0,0,1,1,1
};

// R

int r[256] =

{
1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,
1,1,1,1,1,0,0,1,1,1,1,1,1,1,0,0,
1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,
1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1
};

// S

int s[256] =

{
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0
};

// T

int t[256] =

{
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0
};

// U

int u[256] =

{
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
0,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0
};

// V

int v[256] =

{
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,
1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,
1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
0,0,1,1,1,1,1,0,0,1,1,1,1,1,0,0,
0,0,1,1,1,1,1,0,0,1,1,1,1,1,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0
};

// W

int w[256] =

{
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,0,0,1,1,0,0,1,1,1,1,1,
1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,
1,1,1,1,1,0,1,1,1,1,0,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,
0,1,1,1,1,1,1,0,0,1,1,1,1,1,1,0,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,
0,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0
};

// X

int letterX[256] =

{
1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1
};

// Y

int letterY[256] =

{
1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,
1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,
1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,
1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,
0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,
0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,
0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,
0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0
};

// Z

int z[256] =

{
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,
0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,
0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,
0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,
0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,
0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
};

+ (NSArray *) characterMatchResultsForPoints:(NSArray *)pointObjects {
//	CharacterMatch *aMatch = [Character matchForA:pointObjects];
//	CharacterMatch *bMatch = [Character matchForB:pointObjects];
//	CharacterMatch *cMatch = [Character matchForC:pointObjects];
//	CharacterMatch *dMatch = [Character matchForD:pointObjects];
//	CharacterMatch *eMatch = [Character matchForE:pointObjects];
//	CharacterMatch *fMatch = [Character matchForF:pointObjects];
//	CharacterMatch *gMatch = [Character matchForG:pointObjects];
//	CharacterMatch *hMatch = [Character matchForH:pointObjects];
//	CharacterMatch *iMatch = [Character matchForI:pointObjects];
//	CharacterMatch *jMatch = [Character matchForJ:pointObjects];
//	CharacterMatch *kMatch = [Character matchForK:pointObjects];
//	CharacterMatch *lMatch = [Character matchForL:pointObjects];
//	CharacterMatch *mMatch = [Character matchForM:pointObjects];
	
	CharacterMatch *nMatch = [Character matchForN:pointObjects];
	CharacterMatch *oMatch = [Character matchForO:pointObjects];
	CharacterMatch *pMatch = [Character matchForP:pointObjects];
	
	//CharacterMatch *qMatch = [Character matchForQ:pointObjects];
//	CharacterMatch *rMatch = [Character matchForR:pointObjects];
	
	CharacterMatch *sMatch = [Character matchForS:pointObjects];
	
	//CharacterMatch *tMatch = [Character matchForT:pointObjects];
//	CharacterMatch *uMatch = [Character matchForU:pointObjects];
//	CharacterMatch *vMatch = [Character matchForV:pointObjects];
//	CharacterMatch *wMatch = [Character matchForW:pointObjects];
//	CharacterMatch *xMatch = [Character matchForX:pointObjects];
//	CharacterMatch *yMatch = [Character matchForY:pointObjects];
//	CharacterMatch *zMatch = [Character matchForZ:pointObjects];
	
	NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:26];
//	[results addObject:aMatch];
//	[results addObject:bMatch];
//	[results addObject:cMatch];
//	[results addObject:dMatch];
//	[results addObject:eMatch];
//	[results addObject:fMatch];
//	[results addObject:gMatch];
//	[results addObject:hMatch];
//	[results addObject:iMatch];
//	[results addObject:jMatch];
//	[results addObject:kMatch];
//	[results addObject:lMatch];
//	[results addObject:mMatch];
	
	[results addObject:nMatch];	
	[results addObject:oMatch];
	[results addObject:pMatch];
	
//	[results addObject:qMatch];
//	[results addObject:rMatch];
	
	[results addObject:sMatch];
	
//	[results addObject:tMatch];	
//	[results addObject:uMatch];
//	[results addObject:vMatch];
//	[results addObject:wMatch];
//	[results addObject:xMatch];
//	[results addObject:yMatch];
//	[results addObject:zMatch];
	return results;
	
	
}

+ (CharacterMatch *) matchForA:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:A];
}

+ (CharacterMatch *) matchForB:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:B];
}

+ (CharacterMatch *) matchForC:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:C];
}

+ (CharacterMatch *) matchForD:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:D];
}

+ (CharacterMatch *) matchForE:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:E];
}

+ (CharacterMatch *) matchForF:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:F];
}

+ (CharacterMatch *) matchForG:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:G];
}

+ (CharacterMatch *) matchForH:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:H];
}

+ (CharacterMatch *) matchForI:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:I];
}

+ (CharacterMatch *) matchForJ:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:J];
}

+ (CharacterMatch *) matchForK:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:K];
}

+ (CharacterMatch *) matchForL:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:L];
}

+ (CharacterMatch *) matchForM:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:M];
}

+ (CharacterMatch *) matchForN:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:N];
}

+ (CharacterMatch *) matchForO:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:O];
}

+ (CharacterMatch *) matchForP:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:P];
}

+ (CharacterMatch *) matchForQ:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:Q];
}

+ (CharacterMatch *) matchForR:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:R];
}

+ (CharacterMatch *) matchForS:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:S];
}

+ (CharacterMatch *) matchForT:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:T];
}

+ (CharacterMatch *) matchForU:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:U];
}

+ (CharacterMatch *) matchForV:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:V];
}

+ (CharacterMatch *) matchForW:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:W];
}

+ (CharacterMatch *) matchForX:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:X];
}

+ (CharacterMatch *) matchForY:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:Y];
}

+ (CharacterMatch *) matchForZ:(NSArray *)pointObjects {
	return [Character compareToPointObjects:pointObjects withCharacter:Z];
}

+ (CharacterMatch *) compareToPointObjects:(NSArray *)pointObjects withCharacter:(int)characterRef {

	int pixelCheck;
	
	int *ptr;
	
	float lineCount = 0;
	float linePercentage = 0;

	float totalPercentage = 0;
	
	//NSMutableString *debugString = [[NSMutableString alloc] init];
	//NSString *ON = @"1 ";
	//NSString *OFF = @"0 ";
	//NSString *newLine = @"\n";
							
	//[debugString appendString:newLine];												
																									
	for(int y=0; y<RESOLUTION; y++) {
		for(int x=0; x<RESOLUTION; x++) { //within this loop we are checking on horizontal line at a time
					
			int letterArrayIndex = (y*RESOLUTION) + x;
		
			switch(characterRef) {
				case A: {
					ptr = &a[letterArrayIndex];
					pixelCheck = a[letterArrayIndex];
				}
				break;
				case B: {
					ptr = &b[letterArrayIndex];
					pixelCheck = b[letterArrayIndex];
				}
				break;
				case C: {
					ptr = &c[letterArrayIndex];
					pixelCheck = c[letterArrayIndex];
				}
				break;
				case D: {
					ptr = &d[letterArrayIndex];
					pixelCheck = d[letterArrayIndex];
				}
				break;
				case E: {
					ptr = &e[letterArrayIndex];
					pixelCheck = e[letterArrayIndex];
				}
				break;
				case F: {
					ptr = &f[letterArrayIndex];
					pixelCheck = f[letterArrayIndex];
				}
				break;
				case G: {
					ptr = &g[letterArrayIndex];
					pixelCheck = g[letterArrayIndex];
				}
				break;
				case H: {
					ptr = &h[letterArrayIndex];
					pixelCheck = h[letterArrayIndex];
				}
				break;
				case I: {
					ptr = &i[letterArrayIndex];
					pixelCheck = i[letterArrayIndex];
				}
				break;
				case J: {
					ptr = &j[letterArrayIndex];
					pixelCheck = j[letterArrayIndex];
				}
				break;
				case K: {
					ptr = &k[letterArrayIndex];
					pixelCheck = k[letterArrayIndex];
				}
				break;
				case L: {
					ptr = &l[letterArrayIndex];
					pixelCheck = l[letterArrayIndex];
				}
				break;
				case M: {
					ptr = &m[letterArrayIndex];
					pixelCheck = m[letterArrayIndex];
				}
				break;
				case N: {
					ptr = &n[letterArrayIndex];
					pixelCheck = n[letterArrayIndex];
				}
				break;
				case O: {
					ptr = &o[letterArrayIndex];
					pixelCheck = o[letterArrayIndex];
				}
				break;
				case P: {
					ptr = &p[letterArrayIndex];
					pixelCheck = p[letterArrayIndex];
				}
				break;
				case Q: {
					ptr = &q[letterArrayIndex];
					pixelCheck = q[letterArrayIndex];
				}
				break;
				case R: {
					ptr = &r[letterArrayIndex];
					pixelCheck = r[letterArrayIndex];
				}
				break;
				case S: {
					ptr = &s[letterArrayIndex];
					pixelCheck = s[letterArrayIndex];
				}
				break;
				case T: {
					ptr = &t[letterArrayIndex];
					pixelCheck = t[letterArrayIndex];
				}
				break;
				case U: {
					ptr = &u[letterArrayIndex];
					pixelCheck = u[letterArrayIndex];
				}
				break;
				case V: {
					ptr = &v[letterArrayIndex];
					pixelCheck = v[letterArrayIndex];
				}
				break;
				case W: {
					ptr = &w[letterArrayIndex];
					pixelCheck = w[letterArrayIndex];
				}
				break;
				case X: {
					ptr = &letterX[letterArrayIndex];
					pixelCheck = letterX[letterArrayIndex];
				}
				break;
				case Y: {
					ptr = &letterY[letterArrayIndex];
					pixelCheck = letterY[letterArrayIndex];
				}
				break;
				case Z: {
					ptr = &z[letterArrayIndex];
					pixelCheck = z[letterArrayIndex];
				}
				break;
				default:
				break;
			
			}

					
			
					
			CGPoint point = CGPointMake(x, y);
			PointObject *pointObject = [[PointObject alloc] initWithPoint:point];
			
					
			if( [pointObjects containsObject:pointObject] == YES ) {
			
				//[debugString appendString:ON];

				// the compressed point image has an ON PIXEL HERE
				if(pixelCheck == 1) { // the a character has an ON pixel at this point
					lineCount++;
				}

			}
			else { // the compressed point image has an OFF PIXEL HERE
				
				//[debugString appendString:OFF];
				
				
				if(pixelCheck == 0) { // the a character has an OFF pixel at this point
					lineCount++;
				}
		
			}
			
			[pointObject release];
					
			
	
		} // end of row loop
		
		//[debugString appendString:newLine];
				
		linePercentage = (lineCount / RESOLUTION) * 100;
		totalPercentage += linePercentage;

		//NSLog(@"LINE PERCENTAGE FOR LINE %d: %f", y, linePercentage);
		
		linePercentage = 0;
		lineCount = 0;
		
	} // end of column loop
		

	totalPercentage = totalPercentage / RESOLUTION;	

	//NSLog(@"%d", characterRef);
	//[debugString release];
	
	CharacterMatch *match = [[CharacterMatch alloc] initWithCharacterRef:characterRef percentageMatch:totalPercentage];
	//[match autorelease];
	return match;

}



@end

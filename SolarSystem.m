//
//  main.m
//  GraphicsExample_SolarSystem
//
//  Created by HH on 2015. 9. 26..
//  Copyright © 2015년 HH. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/glut.h>
#import <math.h>

#include "SOIL.h"

#define GL_PI 3.14159f

static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;
static GLfloat zDistance = 0.0f;

GLfloat ambient [] = { 0.5f, 0.5f, 0.5f, 1.0f};
GLfloat diffuse [] = { 0.8f, 0.8f, 0.8f, 1.0f};
GLfloat	lightPos[] = { -50.0f, 50.0f, 100.0f, 1.0f};

GLuint tex[3];

void gltDrawSphere(GLfloat fRadius, GLint iSlices, GLint iStacks)
{
    GLfloat drho = (GLfloat)(3.141592653589) / (GLfloat) iStacks;
    GLfloat dtheta = 2.0f * (GLfloat)(3.141592653589) / (GLfloat) iSlices;
    GLfloat ds = 1.0f / (GLfloat) iSlices;
    GLfloat dt = 1.0f / (GLfloat) iStacks;
    GLfloat t = 1.0f;
    GLfloat s = 0.0f;
    GLint i, j;     // Looping variables
    
    for (i = 0; i < iStacks; i++)
    {
        GLfloat rho = (GLfloat)i * drho;
        GLfloat srho = (GLfloat)(sin(rho));
        GLfloat crho = (GLfloat)(cos(rho));
        GLfloat srhodrho = (GLfloat)(sin(rho + drho));
        GLfloat crhodrho = (GLfloat)(cos(rho + drho));
        
        // Many sources of OpenGL sphere drawing code uses a triangle fan
        // for the caps of the sphere. This however introduces texturing
        // artifacts at the poles on some OpenGL implementations
        glBegin(GL_TRIANGLE_STRIP);
        s = 0.0f;
        for ( j = 0; j <= iSlices; j++)
        {
            GLfloat theta = (j == iSlices) ? 0.0f : j * dtheta;
            GLfloat stheta = (GLfloat)(-sin(theta));
            GLfloat ctheta = (GLfloat)(cos(theta));
            
            GLfloat x = stheta * srho;
            GLfloat y = ctheta * srho;
            GLfloat z = crho;
            
            glTexCoord2f(s, t);
            glNormal3f(x, y, z);
            glVertex3f(x * fRadius, y * fRadius, z * fRadius);
            
            x = stheta * srhodrho;
            y = ctheta * srhodrho;
            z = crhodrho;
            glTexCoord2f(s, t - dt);
            s += ds;
            glNormal3f(x, y, z);
            glVertex3f(x * fRadius, y * fRadius, z * fRadius);
        }
        glEnd();
        
        t -= dt;
    }
}


void SetupRC(){
    glEnable(GL_DEPTH_TEST);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f );
}


void TimerFunction(int value){
    glutPostRedisplay();
    glutTimerFunc(100, TimerFunction, 1);
}

void RenderScene(){
    
    static GLfloat fElect1 = 0.0f;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
    
    glPushMatrix();
    glRotatef(xRot, 1.0f, 0.0f, 0.0f);
    glRotatef(yRot, 0.0f, 1.0f, 0.0f);
    glTranslatef(0.0f,0.0f, zDistance);
    
    
    tex[0] = SOIL_load_OGL_texture("resources/sun.bmp", SOIL_LOAD_AUTO,SOIL_CREATE_NEW_ID, SOIL_FLAG_MIPMAPS | SOIL_FLAG_INVERT_Y | SOIL_FLAG_NTSC_SAFE_RGB | SOIL_FLAG_COMPRESS_TO_DXT);
    tex[1] = SOIL_load_OGL_texture("resources/earth.bmp", SOIL_LOAD_AUTO,SOIL_CREATE_NEW_ID, SOIL_FLAG_MIPMAPS | SOIL_FLAG_INVERT_Y | SOIL_FLAG_NTSC_SAFE_RGB | SOIL_FLAG_COMPRESS_TO_DXT);
    tex[2] = SOIL_load_OGL_texture("resources/moon.bmp", SOIL_LOAD_AUTO,SOIL_CREATE_NEW_ID, SOIL_FLAG_MIPMAPS | SOIL_FLAG_INVERT_Y | SOIL_FLAG_NTSC_SAFE_RGB | SOIL_FLAG_COMPRESS_TO_DXT);
    
    for (int i=0; i<3; i++) {
        glBindTexture(GL_TEXTURE_2D, tex[i]);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    }
    glEnable(GL_TEXTURE_2D);
    
    glLightfv(GL_LIGHT0,GL_AMBIENT, ambient);
    glLightfv(GL_LIGHT0,GL_DIFFUSE, diffuse);
    glLightfv(GL_LIGHT0,GL_POSITION, lightPos);
    glEnable(GL_LIGHT0);
    
    glPushMatrix();
    glRotatef(fElect1, 0.0f, 0.0f, 0.0f);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE,GL_MODULATE );
    glBindTexture(GL_TEXTURE_2D, tex[0]);
    glColor3f(1.0f,1.0f,1.0f);
    gltDrawSphere(5, 50, 50);
    glPopMatrix();
    
    glPushMatrix();
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE,GL_MODULATE );
    glBindTexture(GL_TEXTURE_2D, tex[1]);
    glTranslatef(35.0f,0.0f,0.0f);
    glColor3f(1.0f,1.0f,1.0f);
    gltDrawSphere(2, 50, 50);
    glPopMatrix();
    
    glPushMatrix();
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE,GL_MODULATE );
    glBindTexture(GL_TEXTURE_2D, tex[2]);
    glTranslatef(-15.0f,0.0f,0.0f);
    glColor3f(1.0f,1.0f,1.0f);
    gltDrawSphere(3, 50, 50);
    
    fElect1 += 10.0f;
    if(fElect1 > 360.0f) fElect1 = 0.0f;
    
    glPopMatrix();
    
    
    glutSwapBuffers();
}

void KeyControl(int key, int x, int y){
    if(key == GLUT_KEY_UP) xRot-= 5.0f;
    if(key == GLUT_KEY_DOWN) xRot += 5.0f;
    if(key == GLUT_KEY_LEFT) yRot -= 5.0f;
    if(key == GLUT_KEY_RIGHT) yRot += 5.0f;
    if(key == GLUT_KEY_HOME) zDistance += 5.0f;
    if(key == GLUT_KEY_END) zDistance -= 5.0f;
    
    glutPostRedisplay();
}

void ChangeSize(int w, int h){
    GLfloat fAspect;
    
    glViewport(0,0,w,h);
    fAspect = (GLfloat)w/(GLfloat)h;
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    gluPerspective(45.0f,fAspect,1.0f,500.0f);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0f,0.0f,-50.0f);
    
}

int main(int argc, char* argv[]){
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(800, 300);
    glutInitWindowPosition(0,0);
    glutCreateWindow("Solar System");
    
    glutSpecialFunc(KeyControl);
    glutTimerFunc(33, TimerFunction, 1);
    glutReshapeFunc(ChangeSize);
    glutDisplayFunc(RenderScene);
    
    SetupRC();
    glutMainLoop();
    
}
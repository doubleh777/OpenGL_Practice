//
//  main.m
//  GraphicsExample_Atom
//
//  Created by HH on 2015. 9. 26..
//  Copyright © 2015년 HH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/glut.h>
#import <math.h>
#define GL_PI 3.1415f

static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;

void RenderScene(void){
    
    static GLfloat fElect1 = 0.0f;
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef(0.0f, 0.0f, -100.0f);
    glColor3ub(255, 0, 0);
    glutSolidSphere(10.0f, 15, 15);
    
    glPushMatrix();
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(90.0f, 0.0f, 0.0f);
    glColor3ub(255, 255, 0);
    glutSolidSphere(6.0f, 15, 15);
    glPopMatrix();
    
    glPushMatrix();
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(90.0f, 0.0f, 0.0f);
    glColor3ub(255, 255, 0);
    glutSolidSphere(6.0f, 15, 15);
    glPopMatrix();
    
    glPushMatrix();
    glRotatef(45.0f, 0.0f, 0.0f, 1.0f);
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(-70.0f, 0.0f, 0.0f);
    glColor3ub(255*0.75, 255*0.75, 255*0.75);
    glutSolidSphere(6.0f, 15, 15);
    glPopMatrix();
    
    glPushMatrix();
    glRotatef(90.0f, 0.0f, 0.0f, 1.0f);
    glRotatef(fElect1, 0.0f, 1.0f, 0.0f);
    glTranslatef(0.0f, 0.0f, 60.0f);
    glColor3ub(0, 0, 255);
    glutSolidSphere(6.0f, 15, 15);
    glPopMatrix();
    
    fElect1 += 10.0f;
    if(fElect1 > 360.0f) fElect1 = 0.0f;
    
    
    glutSwapBuffers();
}


void TimerFunction(int value){
    glutPostRedisplay();
    glutTimerFunc(100, TimerFunction, 1);
}

void SetupRC(void){
    
    GLfloat ambientLight[] = {0.3f,0.3f,0.3f};
    GLfloat diffuseLight[] = {1.0f,1.0f,1.0f};
    GLfloat specualLight[] = {0.5f,0.5f,0.5f};

    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glEnable(GL_DEPTH_TEST);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    
    glEnable(GL_LIGHTING);
    
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambientLight);
    glEnable(GL_COLOR_MATERIAL);
    
    glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);

    
    glEnable(GL_COLOR_MATERIAL);
    
    glLightfv(GL_LIGHT0, GL_AMBIENT, ambientLight);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuseLight);
    glLightfv(GL_LIGHT0, GL_SPECULAR, specualLight);
    
    glMaterialfv(GL_FRONT, GL_SPECULAR, specualLight);
    glEnable(GL_LIGHT0);
    
}

void ChangeSize(int w, int h){

    GLfloat fAspect;
    GLfloat light[] = {0.0f, 0.0f, -100.0f, 1.0f};
    
    glViewport(0, 0, w, h);
    fAspect = (GLfloat)w / (GLfloat)h;
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    gluPerspective(60.0f, fAspect, 1.0f, 500.0f);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glLightfv(GL_LIGHT0, GL_POSITION, light);
    glTranslatef(0.0f, 0.0f, -200.f);
}

void KeyControl(int key, int x, int y){
    if(key == GLUT_KEY_UP) xRot -= 5.0f;
    if(key == GLUT_KEY_DOWN) xRot += 5.0f;
    if(key == GLUT_KEY_LEFT) yRot -= 5.0f;
    if(key == GLUT_KEY_RIGHT) yRot += 5.0f;
    
    glutPostRedisplay();
}



void main(int argc, char* argv[]) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
    glutInitWindowSize(512, 512);
    glutInitWindowPosition(0, 0);
    glutCreateWindow("Atom");
    
    glutReshapeFunc(ChangeSize);
    glutTimerFunc(33, TimerFunction, 1);
    glutSpecialFunc(KeyControl);
    glutDisplayFunc(RenderScene);
    SetupRC();
    glutMainLoop();
    
}

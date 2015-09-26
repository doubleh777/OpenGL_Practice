//
//  main.m
//  GraphicsExample_ColorCube
//
//  Created by HH on 2015. 9. 26..
//  Copyright © 2015년 HH. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/glut.h>
#import <math.h>

static GLfloat xRot = 0.0f;
static GLfloat yRot = 0.0f;

void RenderScene(void){
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glMatrixMode(GL_MODELVIEW);
    
    glLoadIdentity();
    glTranslatef(0.0f, 0.0f, -7.0f);
    glRotatef(xRot, 1.0f, 0.0f, 0.0f);
    glRotatef(yRot, 0.0f, 1.0f, 0.0f);
    
    glBegin(GL_QUADS);

    glColor3f(1.0f, 0.0f, 1.0f);  //자주색
    glVertex3f(1.0f, 1.0f, -1.0f);
    glColor3f(1.0f, 1.0f, 1.0f);  //흰색
    glVertex3f(-1.0f, 1.0f, -1.0f);
    glColor3f(0.0f, 1.0f, 1.0f);  //에메랄드색
    glVertex3f(-1.0f, 1.0f, 1.0f);
    glColor3f(0.0f, 0.0f, 1.0f);  //파랑색
    glVertex3f(1.0f, 1.0f, 1.0f);
    
    glColor3f(0.0f, 0.0f, 0.0f);  //검정색
    glVertex3f(1.0f, -1.0f, 1.0f);
    glColor3f(0.0f, 1.0f, 0.0f);  //녹색
    glVertex3f(-1.0f, -1.0f, 1.0f);
    glColor3f(1.0f, 1.0f, 0.0f);  //노란색
    glVertex3f(-1.0f, -1.0f, -1.0f);
    glColor3f(1.0f, 0.0f, 0.0f);  //빨강색
    glVertex3f(1.0f, -1.0f, -1.0f);
    
    glColor3f(0.0f, 0.0f, 1.0f);  //파랑색
    glVertex3f(1.0f, 1.0f, 1.0f);
    glColor3f(0.0f, 1.0f, 1.0f);  //에메랄드색
    glVertex3f(-1.0f, 1.0f, 1.0f);
    glColor3f(0.0f, 1.0f, 0.0f);  //녹색
    glVertex3f(-1.0f, -1.0f, 1.0f);
    glColor3f(0.0f, 0.0f, 0.0f);  //검정색
    glVertex3f(1.0f, -1.0f, 1.0f);
    
    glColor3f(1.0f, 0.0f, 0.0f);  //빨강색
    glVertex3f(1.0f, -1.0f, -1.0f);
    glColor3f(1.0f, 1.0f, 0.0f);  //노랑색
    glVertex3f(-1.0f, -1.0f, -1.0f);
    glColor3f(1.0f, 1.0f, 1.0f);  //흰색
    glVertex3f(-1.0f, 1.0f, -1.0f);
    glColor3f(1.0f, 0.0f, 1.0f);  //자주색
    glVertex3f(1.0f, 1.0f, -1.0f);
    
    glColor3f(0.0f, 1.0f, 1.0f);  //에메랄드색
    glVertex3f(-1.0f, 1.0f, 1.0f);
    glColor3f(1.0f, 1.0f, 1.0f);  //흰색
    glVertex3f(-1.0f, 1.0f, -1.0f);
    glColor3f(1.0f, 1.0f, 0.0f);  //노랑색
    glVertex3f(-1.0f, -1.0f, -1.0f);
    glColor3f(0.0f, 1.0f, 0.0f);  //녹색
    glVertex3f(-1.0f, -1.0f, 1.0f);
    
    glColor3f(1.0f, 0.0f, 1.0f);  //자주색
    glVertex3f(1.0f, 1.0f, -1.0f);
    glColor3f(0.0f, 0.0f, 1.0f);  //파랑색
    glVertex3f(1.0f, 1.0f, 1.0f);
    glColor3f(0.0f, 0.0f, 0.0f);  //검정색
    glVertex3f(1.0f, -1.0f, 1.0f);
    glColor3f(1.0f, 0.0f, 0.0f);  //빨강색
    glVertex3f(1.0f, -1.0f, -1.0f);
    glEnd(); 
    
    glutSwapBuffers();
}

void SetupRC(void){
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
    glShadeModel(GL_SMOOTH);
    glEnable(GL_DEPTH_TEST);
    glFrontFace(GL_CCW);
    glEnable(GL_CULL_FACE);
    
}

void ChangeSize(int w, int h){
    
    GLfloat fAspect;
    glViewport(0, 0, w, h);
    fAspect = (GLfloat)w / (GLfloat)h;
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    gluPerspective(60.0f, fAspect, 1.0f, 500.0f);
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
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
    glutCreateWindow("Color Cube");
    
    glutReshapeFunc(ChangeSize);
    glutSpecialFunc(KeyControl);
    glutDisplayFunc(RenderScene);
    SetupRC();
    glutMainLoop();
    
}

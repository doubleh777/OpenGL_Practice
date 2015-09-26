//
//  main.m
//  GraphicsExample_BouncedRectangles
//
//  Created by HH on 2015. 9. 26..
//  Copyright © 2015년 HH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/glut.h>

GLfloat x_1 = -50.0f;
GLfloat y_1 = 0.0f;

GLfloat x_2 = 50.0f;
GLfloat y_2 = 0.0f;

GLfloat x_3 = -100.0f;
GLfloat y_3 = -75.0f;

GLfloat x_4 = 0.0f;
GLfloat y_4 = -75.0f;

GLsizei rsize = 50.0f;

GLfloat x_1step = 1.0f;
GLfloat y_1step = 1.0f;

GLfloat x_2step = 1.0f;
GLfloat y_2step = 1.0f;

GLfloat x_3step = 1.0f;
GLfloat y_3step = 1.0f;

GLfloat x_4step = 1.0f;
GLfloat y_4step = 1.0f;

GLfloat window_width;
GLfloat window_height;

void RenderScene(void){
    glClear(GL_COLOR_BUFFER_BIT);
    
    glColor3f(0.0f, 1.0f, 0.0f);
    glRectf(x_1, y_1, x_1 + rsize, y_1 + rsize);
    
    glColor3f(0.0f, 0.0f, 0.0f);
    glRectf(x_2, y_2, x_2 + rsize, y_2 + rsize);
    
    glColor3f(1.0f, 0.0f, 0.0f);
    glRectf(x_3, y_3, x_3 + rsize, y_3 + rsize);
    
    glColor3f(0.0f, 0.0f, 1.0f);
    glRectf(x_4, y_4, x_4 + rsize, y_4 + rsize);
    
    
    glutSwapBuffers();
}

void RocationSetting(GLfloat* x, GLfloat* y, GLfloat* xstep, GLfloat* ystep){
    if(*x > window_width - rsize || *x < -window_width) *xstep = -*xstep;
    if(*y > window_height - rsize || *y < -window_height) *ystep = -*ystep;
    if(*x > window_width - rsize) *x = window_width - rsize -1;
    if(*y > window_height - rsize) *y = window_height -rsize - 1;
    
    *x += *xstep;
    *y += *ystep;
}

void TimerFunction(int value){
    
    RocationSetting(&x_1, &y_1, &x_1step, &y_1step);
    RocationSetting(&x_2, &y_2, &x_2step, &y_2step);
    RocationSetting(&x_3, &y_3, &x_3step, &y_3step);
    RocationSetting(&x_4, &y_4, &x_4step, &y_4step);
    
    glutPostRedisplay();
    glutTimerFunc(33, TimerFunction, 1);
}
void SetupRC(void){
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
}

void ChangeSize(GLsizei w, GLsizei h){
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    if(w<=h){
        window_width = 100.0f;
        window_height = 100.0f*h/w;
        glOrtho(-100.0f, 100.0f, -window_height, window_height, 1.0, -1.0);
    }else{
        window_width = 100.0f*w/h;
        window_height = 100.0f*h/w;
        glOrtho(-window_width, window_width, -100.0f, 100.0f, 1.0, -1.0);
    }
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
}

int main(int argc, char * argv[]) {
    
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    glutInitWindowSize(800, 600);
    glutCreateWindow("Bounced Rectangles");
    glutDisplayFunc(RenderScene);
    glutReshapeFunc(ChangeSize);
    glutTimerFunc(2000, TimerFunction, 1);
    SetupRC();
    glutMainLoop();
    return 0;
}

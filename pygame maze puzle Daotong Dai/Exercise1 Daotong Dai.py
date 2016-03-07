from pygame.locals import *
import pygame
import time

class Maze:
    x=[]
    y=[]
    length=0
    def __init__(self):
        self.M=18
        self.N=12
        self.maze1=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                   1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,
                   1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,
                   1,0,1,1,1,1,1,1,0,0,0,0,0,1,0,1,0,1,
                   1,0,1,0,0,0,0,0,0,1,0,0,0,1,0,1,0,1,
                   1,0,1,0,1,1,1,1,0,1,1,1,0,1,0,1,0,1,
                   1,0,1,0,1,0,0,0,0,1,0,0,0,1,0,1,0,1,
                   1,0,1,0,1,0,1,0,0,1,0,0,0,1,0,1,0,1,
                   1,0,1,0,1,0,1,0,0,1,0,1,1,1,0,1,0,1,
                   1,0,1,0,1,0,1,0,0,1,0,0,0,0,0,1,0,1,
                   1,0,0,0,1,0,1,0,0,1,0,0,0,0,0,1,0,1,
                   1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,]

        self.maze2=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                   1,0,1,1,0,0,1,0,0,0,0,1,0,1,0,0,0,1,
                   1,1,0,0,0,0,0,0,1,1,0,1,0,0,0,1,0,1,
                   1,0,1,1,1,1,1,1,0,0,0,1,0,1,0,1,0,1,
                   1,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,1,
                   1,0,1,0,1,1,1,1,0,1,1,1,0,1,0,1,0,1,
                   1,0,0,0,1,0,1,0,0,1,0,0,0,1,0,1,0,1,
                   1,0,1,1,0,0,1,0,0,1,0,0,0,1,0,1,0,1,
                   1,0,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,
                   1,0,1,1,1,0,0,1,0,1,0,0,0,0,0,1,0,1,
                   1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,1,
                   1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,]

        self.maze3=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                   1,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,1,
                   1,0,1,0,0,0,1,0,0,1,0,1,0,1,0,1,0,1,
                   1,0,1,1,1,1,1,1,0,1,0,0,0,1,0,1,0,1,
                   1,0,1,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,
                   1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,0,1,
                   1,0,1,0,1,0,0,0,0,1,0,1,0,1,0,1,0,1,
                   1,0,1,0,1,0,1,0,0,1,0,0,0,1,0,1,0,1,
                   1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,1,0,1,
                   1,0,1,0,1,1,1,0,0,1,0,1,0,1,0,1,0,1,
                   1,0,1,0,0,0,1,0,0,1,0,1,0,0,0,1,0,1,
                   1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,]
        #self.blockList=[]

    def draw(self,display_surf,image_surf,gameState):
       bx = 0
       by = 0
       j=0
       for i in range(0,self.M*self.N):
           if gameState==1:
               if self.maze1[ bx + (by*self.M) ] == 1:
                  display_surf.blit(image_surf,( bx * 44 , by * 44))
                  self.x.insert(j,bx * 44)
                  self.y.insert(j,by * 44)
                  j=j+1
                  self.length=j
                  #print self.length
               bx = bx + 1
               if bx > self.M-1:
                   bx = 0
                   by = by + 1
           elif gameState==2:
               if self.maze2[ bx + (by*self.M) ] == 1:
                  display_surf.blit(image_surf,( bx * 44 , by * 44))
                  self.x.insert(j,bx * 44)
                  self.y.insert(j,by * 44)
                  j=j+1
                  self.length=j
                  #print self.length
               bx = bx + 1
               if bx > self.M-1:
                   bx = 0
                   by = by + 1

           elif gameState==3:
               if self.maze3[ bx + (by*self.M) ] == 1:
                  display_surf.blit(image_surf,( bx * 44 , by * 44))
                  self.x.insert(j,bx * 44)
                  self.y.insert(j,by * 44)
                  j=j+1
                  self.length=j
                  #print self.length
               bx = bx + 1
               if bx > self.M-1:
                   bx = 0
                   by = by + 1



       #print len(self.blockList)


class Player:
    x = 44
    y = 484
    step=44
    direction = 4
    canMoveLeft=True
    canMoveRight=True
    canMoveUp=True
    canMoveDown=True
    #directionBefore = 4

    def update(self):
        #print self.canMoveLeft
        if self.direction == 0 and self.canMoveRight:
            self.x = self.x + self.step
            self.canMoveLeft=True
            self.canMoveRight=True
            self.canMoveUp=True
            self.canMoveDown=True
        if self.direction == 1 and self.canMoveLeft:
            self.x = self.x - self.step
            self.canMoveLeft=True
            self.canMoveRight=True
            self.canMoveUp=True
            self.canMoveDown=True
        if self.direction == 2 and self.canMoveUp:
            self.y = self.y - self.step
            self.canMoveLeft=True
            self.canMoveRight=True
            self.canMoveUp=True
            self.canMoveDown=True
        if self.direction == 3 and self.canMoveDown:
            self.y = self.y + self.step
            self.canMoveLeft=True
            self.canMoveRight=True
            self.canMoveUp=True
            self.canMoveDown=True
        #directionBefore =self.direction
        self.direction=4

    def moveRight(self):
        self.direction = 0

    def moveLeft(self):
        self.direction = 1

    def moveUp(self):
        self.direction = 2

    def moveDown(self):
        self.direction = 3

class Game:
    def isCollision(self,x1,y1,x2,y2,bsize):
        if x1 >= x2 and x1 <= x2 + bsize:
            if y1 >= y2 and y1 <= y2 + bsize:
                return True
        return False
    def checkCollision(self,x1,y1,x2,y2,bsize):
        if x1+bsize==x2 and y1==y2:
            return 0
        if x1-bsize==x2 and y1==y2:
            return 1
        if y1-bsize==y2 and x1==x2:
            return 2
        if y1+bsize==y2 and x1==x2:
            return 3
        else:
            return 4

class GameOver:

    def drawWord(self):
        print "aaaa"


class App:
    windowWidth=800
    windowHeight=600
    player=0
    gameState=1
    gameStateText=""

    def __init__(self):
        self._running=True
        self._display_surf=None
        self._player_surf=None
        self._block_surf=None
        self.player=Player()
        self.maze=Maze()
        self.game = Game()


    def on_init(self):
        pygame.init()
        self._display_surf=pygame.display.set_mode((self.windowWidth,self.windowHeight),pygame.HWSURFACE|pygame.DOUBLEBUF)

        pygame.display.set_caption('Maze puzzle')
        gameIcon = pygame.image.load('player.png')
        pygame.display.set_icon(gameIcon)
        
        self._running = True
        self._player_surf = pygame.image.load("player.png").convert()
        self._block_surf = pygame.image.load("brick.bmp").convert()
        self.gameState=1


    def on_event(self, event):
        if event.type == QUIT:
            self._running = False

    def on_loop(self):
        self.player.update()
        for i in range(0,self.maze.length):
            if self.game.checkCollision(self.player.x,self.player.y,self.maze.x[i],self.maze.y[i],44)==0:
                #print "right"
                self.player.canMoveRight=False
            elif self.game.checkCollision(self.player.x,self.player.y,self.maze.x[i],self.maze.y[i],44)==1:
                #print "left"
                self.player.canMoveLeft=False
            elif self.game.checkCollision(self.player.x,self.player.y,self.maze.x[i],self.maze.y[i],44)==2:
                #print "up"
                self.player.canMoveUp=False
            elif self.game.checkCollision(self.player.x,self.player.y,self.maze.x[i],self.maze.y[i],44)==3:
                #print "down"
                self.player.canMoveDown=False
        if self.player.x==44 and self.player.y==484:
            self.player.canMoveDown=False
        if self.player.x==704 and self.player.y==484:
            self.player.canMoveDown=False
        if self.player.x==704 and self.player.y==484:
            self.gameState=self.gameState+1
            self.player.x=44
            self.player.y=484
        if self.gameState==1:
            self.gameStateText="Maze Puzzle Level 1"
        elif self.gameState==2:
            self.gameStateText="Maze Puzzle Level 2"
        elif self.gameState==3:
            self.gameStateText="Maze Puzzle Level 3"



    def on_render(self):
        self._display_surf.fill((0,0,0))

        if(self.gameState==4):
             font =pygame.font.SysFont("arial", 64)
             text_surface = font.render("Game Over", True, (0, 0, 255))
             self._display_surf.blit(text_surface, (250,150))

             font =pygame.font.SysFont("arial", 32)
             text_surface = font.render("Thank you for playing", True, (0, 0, 255))
             self._display_surf.blit(text_surface, (250,350))

             font =pygame.font.SysFont("arial", 32)
             text_surface = font.render("Developer:Daotong Dai", True, (0, 0, 255))
             self._display_surf.blit(text_surface, (250,450))

        else:
             self._display_surf.blit(self._player_surf,(self.player.x,self.player.y))
             self.maze.draw(self._display_surf, self._block_surf,self.gameState)

             font =pygame.font.SysFont("arial", 50)
             text_surface = font.render(self.gameStateText, True, (0, 0, 255))
             self._display_surf.blit(text_surface, (100,528))

             font =pygame.font.SysFont("arial", 20)
             text_surface = font.render("use direction key to control", True, (0, 0, 255))
             self._display_surf.blit(text_surface, (500,548))

        pygame.display.flip()

    def on_cleanup(self):
        pygame.quit()

    def on_execute(self):

        if self.on_init() == False:
            self._running = False

        while( self._running ):

            for event in pygame.event.get():
                self.on_event(event)

            pygame.event.pump()
            keys = pygame.key.get_pressed()

            if (keys[K_RIGHT]):
                self.player.moveRight()

            if (keys[K_LEFT]):
                self.player.moveLeft()

            if (keys[K_UP]):
                self.player.moveUp()

            if (keys[K_DOWN]):
                self.player.moveDown()

            if (keys[K_ESCAPE]):
                self._running = False

            self.on_loop()
            self.on_render()
            time.sleep (80.0 / 1000.0);
        self.on_cleanup()

if __name__ == "__main__" :
    theApp = App()
    theApp.on_execute()

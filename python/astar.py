#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: astar
learn to use astar
"""
import pygame, time, sys, math
import numpy as np

WALL = 1

class Clock():
    """一个分时器，限制刷新率
    >>> c = Clock(20) # fps
    >>> c.tick(block=False)
    """
    def __init__(self, fps):
        self.set_fps(fps)

    def set_fps(self, fps):
        self.fps = fps
        self.interval = 1.0/float(fps)
        self.pre = time.time()

    def tick(self, block=True):
        """
        检查是否到了时间
        """
        mid = time.time() - self.pre
        if  mid < self.interval:
            if block:
                time.sleep(self.interval - mid)
            else:
                return
        self.pre = time.time()
        return True


def show(map, a, b):
    # 计算
    opens, closes, P, F, G, H = astar(map, a, b)
    w, h = map.shape
    
    pygame.init()
    size = map.shape
    SIZE = 50
    screen = pygame.display.set_mode(
        (size[0]*SIZE + 100,
         size[1]*SIZE))

    def drawmap():
        # 根据结果绘图
        def draw(p, color):
            x = p[0] * SIZE
            y = p[1] * SIZE
            w, h = SIZE, SIZE
            pygame.draw.rect(screen, color,
                             pygame.Rect(x, y, w, h))
        # 绘制点
        for n in opens:
            draw(n, (0, 255, 0))
        for n in closes:
            draw(n, (0, 0, 255))
        # wall
        for i in range(w):
            for j in range(h):
                if map[i, j] == WALL:
                    draw((i,j), (128, 128, 128))
        # path
        p = b
        while p != None:
            draw(p, (200, 0, 0))
            p = P[p]

        # a and b
        draw(a, (255, 255, 0))
        draw(b, (0, 255, 255))

        # values
        font = pygame.font.SysFont('sans', 8)
        for n, v in F.iteritems():
            sur = font.render(str(v), True, (0,0,0))
            screen.blit(
                sur, (n[0]*SIZE+3, n[1]*SIZE+3))
        for n, v in G.iteritems():
            sur = font.render(str(v), True, (0,0,0))
            screen.blit(
                sur, (n[0]*SIZE+3, n[1]*SIZE+40))
        for n, v in H.iteritems():
            sur = font.render(str(v), True, (0,0,0))
            screen.blit(
                sur, (n[0]*SIZE+35, n[1]*SIZE+40))
        
        # parents
        for k, v in P.iteritems():
            if not v: continue
            d = k[0] - v[0], k[1] - v[1]
            pygame.draw.line(
                screen, (12, 12, 12),
                (k[0]*SIZE + SIZE/2,
                 k[1]*SIZE + SIZE/2),
                (k[0]*SIZE + SIZE/2 - d[0]*SIZE/2,
                 k[1]*SIZE + SIZE/2 - d[1]*SIZE/2),
                2)
            pygame.draw.circle(
                screen, (12, 12, 12),
                (k[0]*SIZE + SIZE/2,
                 k[1]*SIZE + SIZE/2),
                SIZE/4
                )
            
    drawmap()
    clock = Clock(30)    
    while True:
        clock.tick()
        # 退出判断
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                sys.exit()

        pygame.display.flip()
    

def astar(map, a, b):
    """
    A*算法
    """
    w, h = map.shape
    opens = []
    closes = []
    
    F = {}
    G = {}
    H = {}
    # point to parent
    P = {}

    # init
    current = a
    opens.append(current)
    G[current] = 0
    H[current] = 0
    F[current] = 0
    P[current] = None

    # loop
    while current != b:
        # close current
        opens.remove(current)
        closes.append(current)

        # check nears
        DIRS = [(-1, 0), (0, -1), (1, 0), (0, 1),
                (-1, -1), (-1, +1), (+1, -1), (+1, +1)]
        nears = [(current[0] + d[0],
                  current[1] + d[1])
                 for d in DIRS]
        costs = [10, 10, 10, 10, 14, 14, 14, 14]
        
        for i, n in enumerate(nears):
            cost = costs[i]
            # remove out of the map
            if n[0] < 0 or n[0] >= w \
               or n[1] < 0 or n[1] >= h:
                continue
            # remove wall
            if map[n] == WALL:
                continue
            # remove closed
            if n in closes:
                continue
            # check near then current
            if n in opens:
                # check new value
                if G[n] > G[current] + cost:
                    G[n] = G[current] + cost
                    F[n] = G[n] + H[n]
                    P[n] = current
                continue

            # init to opens
            opens.append(n)
            G[n] = G[current] + cost
            # 核心的关系函数, 改动后影响搜索方式
            H[n] = (abs(b[0] - n[0]) + abs(b[1] - n[1])) *10
            F[n] = G[n] + H[n]
            P[n] = current
            
        # next
        if len(opens) <= 0: break
        current = min(opens[-10:], key=lambda n: F[n])
        if current == b: break

    return opens, closes, P, F, G, H

def main():
    map = np.zeros((30,15))
    for i in range(6, 30, 5):
        for j in range(10):
            if i % 2:
                j = map.shape[1] - j - 1
            map[i, j] = WALL
    show(map, (5, 5), (25, 10))
    
if __name__=="__main__":
    main()

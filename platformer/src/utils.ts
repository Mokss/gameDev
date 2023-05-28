import type { Block } from './types';

export const isCollision = (block1: Block, block2: Block) => 
	block1.position.y + block1.height >= block2.position.y &&
    block1.position.x + block1.width >= block2.position.x &&
    block1.position.y <= block2.position.y + block2.height &&
    block1.position.x <= block2.position.x + block2.width;

export const isPlatformCollision = (block1: Block, block2: Block) => 
	block1.position.y + block1.height >= block2.position.y &&
    block1.position.x + block1.width >= block2.position.x &&
    block1.position.y + block1.height <= block2.position.y + block2.height &&
    block1.position.x <= block2.position.x + block2.width;
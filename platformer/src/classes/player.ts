import { gravity } from '../constants.js';
import type { Position } from '../types';
import { CollisionBlock } from './collisionBlock.js';
import { isCollision } from '../utils.js';

export interface PlayerProps{
	canvas: HTMLCanvasElement;
    position: Position;
	velocity?: Position;
	collisionBlocks: CollisionBlock[]
}

export class Player {
	canvas:  HTMLCanvasElement;
	context: CanvasRenderingContext2D;
	position: Position;
	velocity: Position;
	collisionBlocks: CollisionBlock[] = [];
	height = 25;
	width = 25;

	constructor(props: PlayerProps) {
		this.canvas = props.canvas;
		this.context = props.canvas.getContext('2d') as CanvasRenderingContext2D;
		this.position = props.position;
		this.velocity = props.velocity || {
			x: 0,
			y: 1,
		};
		this.collisionBlocks = props.collisionBlocks;
	}

	draw() {
		this.context.fillStyle = 'red';
		this.context.fillRect(this.position.x, this.position.y, this.width, this.height);
	}

	update() {
		this.draw();

		this.position.x += this.velocity.x;
		this.checkHorizontalCollision();
		this.applyGravity();
		this.checkVerticalCollision();
	}

	applyGravity() {
		this.position.y += this.velocity.y;
		this.velocity.y += gravity;
	}


	checkHorizontalCollision() {
		for (let i = 0; i < this.collisionBlocks.length; i++) {
			const collisionBLock = this.collisionBlocks[i];

			if (isCollision(this, collisionBLock)) {
				if (this.velocity.x > 0) { 
					this.velocity.x = 0;
					this.position.x = collisionBLock.position.x - this.width - 0.01;
					break;
				}

				if (this.velocity.x < 0) { 
					this.velocity.x = 0;
					this.position.x = collisionBLock.position.x + collisionBLock.width + 0.01;
					break;
				}
			}
		}
	}

	checkVerticalCollision() {
		for (let i = 0; i < this.collisionBlocks.length; i++) {
			const collisionBLock = this.collisionBlocks[i];


			if (isCollision(this, collisionBLock)) {
				if (this.velocity.y > 0) { 
					this.velocity.y = 0;
					this.position.y = collisionBLock.position.y - this.height - 0.01;
					break;
				}

				if (this.velocity.y < 0) { 
					this.velocity.y = 0;
					this.position.y = collisionBLock.position.y + collisionBLock.height + 0.01;
					break;
				}
			}
		}
	}
}
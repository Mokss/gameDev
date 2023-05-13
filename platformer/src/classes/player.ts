import { gravity } from '../constants.js';
import type { Block, Position } from '../types';
import { CollisionBlock } from './collisionBlock.js';
import { isCollision } from '../utils.js';
import { SpriteProps, Sprite } from './sprite.js';

export interface PlayerProps extends SpriteProps {
	velocity?: Position;
	collisionBlocks: CollisionBlock[]
}

export class Player extends Sprite {
	velocity: Position;
	collisionBlocks: CollisionBlock[] = [];
	hitbox: Block;

	constructor(props: PlayerProps) {
		super({ ...props, scale: 0.5 });
		this.velocity = props.velocity || {
			x: 0,
			y: 1,
		};
		this.collisionBlocks = props.collisionBlocks;
		this.hitbox = {
			position: {
				x: this.position.x,
				y: this.position.y,
			},
			width: 10,
			height: 10
		};
	}

	update() {
		this.updateFrames();
		// this.updateHitbox();
		
		// NOTE: img borders
		this.context.fillStyle = 'rgba(0, 255, 0, 0.2)';
		this.context.fillRect(this.position.x, this.position.y, this.width, this.height);

		// NOTE: hitbox borders
		this.context.fillStyle = 'rgba(255, 0, 0, 0.2)';
		this.context.fillRect(this.hitbox.position.x, this.hitbox.position.y, this.hitbox.width, this.hitbox.height);

		this.draw();

		this.position.x += this.velocity.x;
		this.updateHitbox();
		this.checkHorizontalCollision();
		this.applyGravity();
		this.updateHitbox();
		this.checkVerticalCollision();
	}

	applyGravity() {
		this.position.y += this.velocity.y;
		this.velocity.y += gravity;
	}


	checkHorizontalCollision() {
		for (let i = 0; i < this.collisionBlocks.length; i++) {
			const collisionBLock = this.collisionBlocks[i];

			if (isCollision(this.hitbox, collisionBLock)) {
				if (this.velocity.x > 0) { 
					this.velocity.x = 0;

					const offset = this.hitbox.position.x - this.position.x + this.hitbox.width;

					this.position.x = collisionBLock.position.x - offset - 0.01;
					break;
				}

				if (this.velocity.x < 0) { 
					this.velocity.x = 0;

					const offset = this.hitbox.position.x - this.position.x;

					this.position.x = collisionBLock.position.x + collisionBLock.width - offset + 0.01;
					break;
				}
			}
		}
	}

	checkVerticalCollision() {
		for (let i = 0; i < this.collisionBlocks.length; i++) {
			const collisionBLock = this.collisionBlocks[i];


			if (isCollision(this.hitbox, collisionBLock)) {
				if (this.velocity.y > 0) { 
					this.velocity.y = 0;

					const offset = this.hitbox.position.y - this.position.y + this.hitbox.height;

					this.position.y = collisionBLock.position.y - offset - 0.01;
					break;
				}

				if (this.velocity.y < 0) { 
					this.velocity.y = 0;

					const offset = this.hitbox.position.y - this.position.y;

					this.position.y = collisionBLock.position.y + collisionBLock.height - offset + 0.01;
					break;
				}
			}
		}
	}

	updateHitbox() {
		this.hitbox = {
			position: {
				x: this.position.x + 34,
				y: this.position.y + 26,
			},
			width: 15,
			height: 27
		};
	}
}
import { gravity } from '../constants.js';
import type { Animations, Block, Position } from '../types';
import { CollisionBlock } from './collisionBlock.js';
import { isCollision } from '../utils.js';
import { SpriteProps, Sprite } from './sprite.js';

export interface PlayerProps<T> extends SpriteProps {
	velocity?: Position;
	collisionBlocks: CollisionBlock[]
	animations: Animations<T>
}

export class Player<T> extends Sprite {
	velocity: Position;
	collisionBlocks: CollisionBlock[] = [];
	animations: Animations<T>;
	lastDirection: 'right' | 'left' = 'right';

	constructor(props: PlayerProps<T>) {
		super({ ...props, scale: 0.5 });
		this.velocity = props.velocity || {
			x: 0,
			y: 1,
		};
		this.collisionBlocks = props.collisionBlocks;
		this.animations = props.animations;

		for (const key in props.animations) {
			const img = new Image();
			img.src = props.animations[key].src;
			this.animations[key].img = img;
		}
	}

	get hitbox(): Block {
		return {
			position: {
				x: this.position.x + 34,
				y: this.position.y + 26,
			},
			width: 15,
			height: 27
		};
	}

	update() {
		this.updateFrames();
		this.draw();

		this.position.x += this.velocity.x;
		this.checkHorizontalCollision();
		this.applyGravity();
		this.checkVerticalCollision();
	}

	applyGravity() {
		this.velocity.y += gravity;
		this.position.y += this.velocity.y;
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

	switchSprite(sprite: keyof T) {
		const animation = this.animations[sprite];
		if (!animation.img || this.image === animation.img || !this.loaded) return;
	
		this.image = animation.img;
		this.frameBuffer = animation.frameBuffer;
		this.frameRate = animation.frameRate;
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
}
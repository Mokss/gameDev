import { GRAVITY, SCALE } from '../constants.js';
import type { Animations, Block, Position } from '../types';
import { CollisionBlock } from './collisionBlock.js';
import { isCollision, isPlatformCollision } from '../utils.js';
import { SpriteProps, Sprite } from './sprite.js';

export interface PlayerProps<T> extends SpriteProps {
	velocity?: Position;
	collisionBlocks: CollisionBlock[];
	platformCollisionBlocks: CollisionBlock[];
	animations: Animations<T>;
}

export class Player<T> extends Sprite {
	velocity: Position;
	collisionBlocks: CollisionBlock[] = [];
	platformCollisionBlocks: CollisionBlock[] = [];
	animations: Animations<T>;
	lastDirection: 'right' | 'left' = 'right';

	constructor(props: PlayerProps<T>) {
		super({ ...props, scale: 0.5 });
		this.velocity = props.velocity || {
			x: 0,
			y: 1,
		};
		this.collisionBlocks = props.collisionBlocks;
		this.platformCollisionBlocks = props.platformCollisionBlocks;
		this.animations = props.animations;

		for (const key in props.animations) {
			const img = new Image();
			img.src = props.animations[key].src;
			this.animations[key].img = img;
		}
	}

	get camerabox(): Block {
		return  {
			position: {
				x: this.position.x - 60,
				y: this.position.y
			},
			width: 200,
			height: 80
		};
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

	shouldPanCameraLeft(canvas: HTMLCanvasElement, camera: {position: Position }) {
		const cameraboxRightSide = this.camerabox.position.x + this.camerabox.width;

		if (cameraboxRightSide >= 576) return;

		if (cameraboxRightSide >= canvas.width / SCALE + Math.abs(camera.position.x)) {
			camera.position.x -= this.velocity.x;
		}
	}

	shouldPanCameraRight(camera: {position: Position }) {
		if(this.camerabox.position.x <= 0) return;

		if (this.camerabox.position.x <= Math.abs(camera.position.x)) {
			camera.position.x -= this.velocity.x;
		}
	}

	shouldPanCameraDown(camera: {position: Position }) {
		if(this.camerabox.position.y + this.velocity.y <= 0) return;

		if (this.camerabox.position.y <= Math.abs(camera.position.y)) {
			camera.position.y -= this.velocity.y;
		}
	}

	shouldPanCameraUp(canvas: HTMLCanvasElement, camera: {position: Position }) {
		if(this.camerabox.position.y + this.camerabox.height + this.velocity.y >= 432) return;

		if (this.camerabox.position.y + this.camerabox.height >= Math.abs(camera.position.y) + canvas.height / SCALE) {
			camera.position.y -= this.velocity.y;
		}
	}

	update() {
		this.updateFrames();

		this.context.fillStyle = 'rgba(0, 0, 255, 0.2)';
		this.context.fillRect(
			this.camerabox.position.x,
			this.camerabox.position.y,
			this.camerabox.width,
			this.camerabox.height
		);

		this.draw();

		this.position.x += this.velocity.x;
		this.checkHorizontalCollision();
		this.applyGravity();
		this.checkVerticalCollision();
	}

	applyGravity() {
		this.velocity.y += GRAVITY;
		this.position.y += this.velocity.y;
	}

	switchSprite(sprite: keyof T) {
		const animation = this.animations[sprite];
		if (!animation.img || this.image === animation.img || !this.loaded) return;
	
		this.currentFrame = 0;
		this.image = animation.img;
		this.frameBuffer = animation.frameBuffer;
		this.frameRate = animation.frameRate;
	}

	checkHorizontalCanvasCollision() {
		if (
			this.hitbox.position.x + this.hitbox.width + this.velocity.x >= 576 ||
			this.hitbox.position.x + this.velocity.x <= 0	
		) {
			this.velocity.x = 0;
		}
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
			const collisionBlock = this.collisionBlocks[i];

			if (isCollision(this.hitbox, collisionBlock)) {
				if (this.velocity.y > 0) { 
					this.velocity.y = 0;

					const offset = this.hitbox.position.y - this.position.y + this.hitbox.height;

					this.position.y = collisionBlock.position.y - offset - 0.01;
					break;
				}
			}
		}

		for (let i = 0; i < this.platformCollisionBlocks.length; i++) {
			const collisionBLock = this.platformCollisionBlocks[i];

			if (isPlatformCollision(this.hitbox, collisionBLock)) {
				if (this.velocity.y > 0) { 
					this.velocity.y = 0;

					const offset = this.hitbox.position.y - this.position.y + this.hitbox.height;

					this.position.y = collisionBLock.position.y - offset - 0.01;
					break;
				}
			}
		}
	}
}
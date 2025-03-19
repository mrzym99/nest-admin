import * as randomName from 'node-random-name';

export function randomNumber(min = 0, max = 10) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

export function randomNickName() {
  return randomName({ last: true });
}

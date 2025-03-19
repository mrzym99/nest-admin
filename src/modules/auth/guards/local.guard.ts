import { AuthGuard } from '@nestjs/passport';
import { AuthStrategy } from '../auth.constant';

export class LocalGuard extends AuthGuard(AuthStrategy.LOCAL) {
  // context: ExecutionContext
  async canActivate(): Promise<boolean> {
    return true;
  }
}

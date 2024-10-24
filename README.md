# ft_transcendance

## Usage

1. `git submodule init`
2. `git submodule update`
3. `srcs/confidential/.env`를 `srcs/nginx/frontend`에 복사
4. `make`


vite.config.js 수정해주세요 도커 데브 환경에서 이래 해야댐.
경로 안맞는거 빌드 해서 확인해주세요.

```
import { defineConfig } from 'vite';
import jsconfigPaths from 'vite-jsconfig-paths';

export default defineConfig({
  plugins: [jsconfigPaths()],
  esbuild: {
    jsx: 'transform',
    jsxInject: `import { jsx, Fragment } from '@lib/jsx/jsx-runtime'`,
    jsxFactory: 'jsx',
    jsxFragment: 'Fragment',
  },
  resolve: {
    alias: {
      '@': "./",
      '@lib': './library',
    },
  },
  server: {
    host: '0.0.0.0',
    port: 3100,
    watch: {
      usePolling: true  // Docker 환경에서 파일 변경 감지를 위해 필요
    },
    headers: {
      'Content-Security-Policy': "script-src 'self' 'unsafe-inline' 'unsafe-eval' https: http:;"
    }
  },
});
```

```
import { defineConfig } from 'vite';
import jsconfigPaths from 'vite-jsconfig-paths';

export default defineConfig({
  plugins: [jsconfigPaths()],
  esbuild: {
    jsx: 'transform',
    jsxInject: `import { jsx, Fragment } from '@lib/jsx/jsx-runtime'`,
    jsxFactory: 'jsx',
    jsxFragment: 'Fragment',
  },
  resolve: {
    alias: {
      '@': '/src',
      '@lib': '/src/library',
    },
  },
  server: {
    host: '0.0.0.0',
    port: 3100,
    hmr: {
      path: '/hmr',
      port: 24678,
    }
  },
});
```
```
import { defineConfig } from 'vite';
import jsconfigPaths from 'vite-jsconfig-paths';

export default defineConfig({
  plugins: [jsconfigPaths()],
  esbuild: {
    jsx: 'transform',
    jsxInject: `import { jsx, Fragment } from '@lib/jsx/jsx-runtime'`,
    jsxFactory: 'jsx',
    jsxFragment: 'Fragment',
  },
  resolve: {
    alias: {
      '@': '/src',
      '@lib': '/src/library',
    },
  },
  server: {
    host: '0.0.0.0',
    port: 3100,
    hmr: {
      path: 'hmr',
      protocol: 'wss',
      clientPort: 443,
      host: 'localhost'
    }
  },
});
```
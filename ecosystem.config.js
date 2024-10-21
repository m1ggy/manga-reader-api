module.exports = {
    apps: [
      {
        name: 'reader-api',
        script: 'ts-node',
        args: 'src/main.ts',
        watch: false,
        env: {
          NODE_ENV: 'production',
        },
      },
    ],
  }
  
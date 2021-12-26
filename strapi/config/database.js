module.exports = ({ env }) => ({
  defaultConnection: 'default',
  connections: {
    default: {
      connector: 'bookshelf',
      settings: {
        client: 'mysql',
        host: env('DATABASE_HOST', 'mysql'),
        port: env.int('DATABASE_PORT', 3306),
        database: env('DATABASE_NAME', 'woopear'),
        username: env('DATABASE_USERNAME', 'woopear'),
        password: env('DATABASE_PASSWORD', 'woopear@woopearWeb76'),
        ssl: env.bool('DATABASE_SSL', false),
      },
      options: {}
    },
  },
});

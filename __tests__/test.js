const request = require('supertest');
const app = require('../app');

describe('GET /', () => {
  it('should return 200 OK and render the index page', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toEqual(200);
    expect(res.text).toContain('Welcome to Express'); 
  });
});

describe('GET /users', () => {
  it('should return 200 OK and respond with a resource', async () => {
    const res = await request(app).get('/users');
    expect(res.statusCode).toEqual(200);
    expect(res.text).toContain('respond with a resource'); 
  });
});

describe('GET /nonexistent', () => {
  it('should return 404 for nonexistent routes', async () => {
    const res = await request(app).get('/nonexistent');
    expect(res.statusCode).toEqual(404);
  });
});

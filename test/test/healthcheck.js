"use strict";

// Internal healthcheck

// lib
const assert = require("assert");
const axios = require("axios");

// env
const os = require("os");
const inDocker = os.hostname() === "test";
const port = inDocker ? 80 : parseInt(process.env.MS_PORT_PUBLIC);
const host = inDocker ? "openresty-app" : process.env.MS_HOST_PUBLIC;

assert.notEqual(port, NaN, "specify public port via environment, e.g.: MS_HOST_PUBLIC=localhost MS_PORT_PUBLIC=8087 npm run test");
assert.notEqual(host, NaN, "specify public host via environment, e.g.: MS_HOST_PUBLIC=localhost MS_PORT_PUBLIC=8087 npm run test");

// Test URI
let uri = `http://${host}:${port}/healthcheck`;

describe("healthcheck", () => {

    it("healthcheck", async () => {
        let response;
        try {
            response = await axios.get(uri);
        } catch (error) {
            assert.fail(`failed to fetch ${uri}`);
            return;
        }

        assert.strictEqual(response.headers["content-type"], "application/json");
        assert.deepStrictEqual(response.data, {result: "ok"});
    });

});
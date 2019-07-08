const cfAuth = require("@stinkstudios/cf-auth").default;

exports.handler = (event, context, callback) =>
  cfAuth(
    {
      validCredentails: [
        {
          username: "admin",
          password: "ttw"
        }
      ],
      whitelistedIPs: []
    },
    event,
    callback
  );

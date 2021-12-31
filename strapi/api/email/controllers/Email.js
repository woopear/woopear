// File /api/email/controllers/Email.js
"use strict";

/**
 * Read the documentation () to implement custom controller functions
 */

module.exports = {
  /**
   * Sends an email to the recipient in the body of the request
   */
  send: async (ctx) => {
    const body = ctx.request.body;
    const sendTo = "woopears@gmail.com";

    try {
      const emailOptions = {
        to: sendTo,
        subject: "Contact pour un projet",
        html: `<h1>Message de contact !
        </h1><p>Email : ${body.email}</p>
        <p>Tel : ${body.tel ? body.tel : "pas renseigné"}</p>
        <p>Message : ${body.message}</p>`,
      };
      await strapi.plugins["email"].services.email.send(emailOptions);
      strapi.log.debug(`Email envoyé à : ${sendTo}`);
      ctx.send({ message: "Email sent" });
    } catch (err) {
      strapi.log.error(`Error envoie email à ${sendTo}`, err);
      ctx.send({ error: "Error envoie email" });
    }
  },
};

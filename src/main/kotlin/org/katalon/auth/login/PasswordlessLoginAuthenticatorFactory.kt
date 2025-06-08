package org.katalon.auth.login

import org.keycloak.authentication.authenticators.browser.WebAuthnPasswordlessAuthenticatorFactory
import org.keycloak.models.KeycloakSession

class PasswordlessLoginAuthenticatorFactory: WebAuthnPasswordlessAuthenticatorFactory() {
    private val providerId = "katalon-authenticator-passwordless"

    override fun create(session: KeycloakSession) = PasswordlessLoginAuthenticator(session)

    override fun getId() = providerId

    override fun getDisplayType() = "Katalon Passwordless Login"

    override fun getHelpText() = "Katalon Passwordless Login"

}

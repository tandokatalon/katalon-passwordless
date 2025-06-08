package org.katalon.auth.login

import org.keycloak.authentication.AuthenticationFlowContext
import org.keycloak.authentication.authenticators.browser.UsernameForm
import org.keycloak.authentication.authenticators.browser.WebAuthnPasswordlessAuthenticator
import org.keycloak.models.KeycloakSession

class PasswordlessLoginAuthenticator(
    session: KeycloakSession
) : WebAuthnPasswordlessAuthenticator(session) {

    override fun authenticate(context: AuthenticationFlowContext) {
        super.authenticate(context)
    }

}

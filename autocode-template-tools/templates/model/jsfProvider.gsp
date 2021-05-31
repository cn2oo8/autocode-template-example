<jsf:provider id="accountProviderJsf"
              interface="com.jd.b2b.user.core.sdk.AccountProvider"
              alias="${jsf.provider.usercore.alias}" ref="accountProviderImpl"
              delay="${jsf.provider.config.onlineDelay}"/>
#!/bin/bash

# Function to get the default namespace from the active kubectl context
get_namespace() {
    local ns=$1
    if [ -n "$ns" ]; then
        echo "$ns"
    else
        local ctx_namespace=$(kubectl config view --minify --output=jsonpath='{.contexts[0].context.namespace}')
        echo "${ctx_namespace:-default}"
    fi
}

# Function to get secret value
get_secret_value() {
    local ns=$1
    local secret=$2
    local key=$3
    local value=$(kubectl -n "$ns" get secret "$secret" -o jsonpath="{.data.$key}" | base64 --decode)
    echo "$value"
}

# Function to get the FQDN of the deployment
get_fqdn() {
    local ns=$1
    local ingress_name=$(kubectl -n "$ns" get ingress -o jsonpath="{.items[0].metadata.name}")
    local fqdn=$(kubectl -n "$ns" get ingress "$ingress_name" -o jsonpath="{.spec.rules[0].host}")
    echo "$fqdn"
}

# Function to print secrets
print_secrets() {
    local ns=$1
    echo "Relevant passwords:"
    echo "$(get_secret_value "$ns" "am-env-secrets" "AM_PASSWORDS_AMADMIN_CLEAR") (amadmin user)"
    echo "$(get_secret_value "$ns" "ds-passwords" "dirmanager\\.pw") (uid=admin user)"
    echo "$(get_secret_value "$ns" "ds-env-secrets" "AM_STORES_APPLICATION_PASSWORD") (App str svc acct (uid=am-config,ou=admins,ou=am-config))"
    echo "$(get_secret_value "$ns" "ds-env-secrets" "AM_STORES_CTS_PASSWORD") (CTS svc acct (uid=openam_cts,ou=admins,ou=famrecords,ou=openam-session,ou=tokens))"
    echo "$(get_secret_value "$ns" "ds-env-secrets" "AM_STORES_USER_PASSWORD") (ID repo svc acct (uid=am-identity-bind-account,ou=admins,ou=identities))"
}

# Function to print URLs
print_urls() {
    local ns=$1
    local fqdn=$(get_fqdn "$ns")
    echo "Relevant URLs:"
    echo "https://$fqdn/platform"
    echo "https://$fqdn/admin"
    echo "https://$fqdn/am"
    echo "https://$fqdn/enduser"
}

# Main execution
namespace=$(get_namespace "$1")
echo "Targeting namespace: \"$namespace\"."
echo ""

print_secrets "$namespace"
echo ""

print_urls "$namespace"


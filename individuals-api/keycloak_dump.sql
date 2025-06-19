--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
756b6c8b-fab4-4ec1-9de6-2b22fc628505	8355087a-9dd9-4cc4-b248-fadb89e47fa6
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
e1282a1c-d1e1-41f1-8d85-78d5917df3eb	\N	auth-cookie	62548a37-f59d-45a0-adc9-27061011b0f3	f616f338-c4c6-423d-ae7f-96f394153f27	2	10	f	\N	\N
c8c37147-1fa2-40ad-abe6-6588e9ff0a51	\N	auth-spnego	62548a37-f59d-45a0-adc9-27061011b0f3	f616f338-c4c6-423d-ae7f-96f394153f27	3	20	f	\N	\N
932fdf05-2ff4-4b75-b781-40e59250826f	\N	identity-provider-redirector	62548a37-f59d-45a0-adc9-27061011b0f3	f616f338-c4c6-423d-ae7f-96f394153f27	2	25	f	\N	\N
379a5bc6-d9ed-4387-b8bf-8d8ad1949565	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	f616f338-c4c6-423d-ae7f-96f394153f27	2	30	t	8d4f6c49-9328-4a3d-8d04-c69fd324c71e	\N
275051a5-41fc-45e1-9c3f-58244e87bf1d	\N	auth-username-password-form	62548a37-f59d-45a0-adc9-27061011b0f3	8d4f6c49-9328-4a3d-8d04-c69fd324c71e	0	10	f	\N	\N
07f02eaa-45c5-4d9d-83c2-70a91cc6cc21	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	8d4f6c49-9328-4a3d-8d04-c69fd324c71e	1	20	t	838932c5-419b-401b-934e-e37cb8e824ed	\N
ef30ea1b-ea9b-45e7-9cc8-c7d7e6edc54d	\N	conditional-user-configured	62548a37-f59d-45a0-adc9-27061011b0f3	838932c5-419b-401b-934e-e37cb8e824ed	0	10	f	\N	\N
84e6323d-a4b4-4642-b2be-40b06dd3cf0b	\N	auth-otp-form	62548a37-f59d-45a0-adc9-27061011b0f3	838932c5-419b-401b-934e-e37cb8e824ed	0	20	f	\N	\N
d71d3f3c-091b-41aa-b177-95b64ce7836e	\N	direct-grant-validate-username	62548a37-f59d-45a0-adc9-27061011b0f3	dc77fc60-7c97-4461-9ff1-9c688e1cb1f6	0	10	f	\N	\N
33fd3670-3675-4ab0-8271-ed76f7f5a97c	\N	direct-grant-validate-password	62548a37-f59d-45a0-adc9-27061011b0f3	dc77fc60-7c97-4461-9ff1-9c688e1cb1f6	0	20	f	\N	\N
b0021bc2-7ab2-4e94-832d-02325fcfedb2	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	dc77fc60-7c97-4461-9ff1-9c688e1cb1f6	1	30	t	cba65c95-5244-4a8d-bcec-5c5ffce70d5d	\N
9fa5a720-1178-4973-9f62-66891f7c6cde	\N	conditional-user-configured	62548a37-f59d-45a0-adc9-27061011b0f3	cba65c95-5244-4a8d-bcec-5c5ffce70d5d	0	10	f	\N	\N
d0bed277-4ee1-4e38-af3c-5fa7ca27fe3d	\N	direct-grant-validate-otp	62548a37-f59d-45a0-adc9-27061011b0f3	cba65c95-5244-4a8d-bcec-5c5ffce70d5d	0	20	f	\N	\N
a694ae3e-2f2f-4438-a19a-92f4b0fdd675	\N	registration-page-form	62548a37-f59d-45a0-adc9-27061011b0f3	151a8c2d-0e03-4aa2-8f42-3d49b50b366d	0	10	t	9ba76793-3bc5-4c14-a196-9f2582f310fb	\N
503930ef-cff5-488a-9a8d-41c81da3aa1e	\N	registration-user-creation	62548a37-f59d-45a0-adc9-27061011b0f3	9ba76793-3bc5-4c14-a196-9f2582f310fb	0	20	f	\N	\N
459e31b9-eec6-43ae-a9d6-9b406516523f	\N	registration-password-action	62548a37-f59d-45a0-adc9-27061011b0f3	9ba76793-3bc5-4c14-a196-9f2582f310fb	0	50	f	\N	\N
09b05f41-f3e5-4ef0-a805-ea6a6e3be01f	\N	registration-recaptcha-action	62548a37-f59d-45a0-adc9-27061011b0f3	9ba76793-3bc5-4c14-a196-9f2582f310fb	3	60	f	\N	\N
b70cba0f-02ef-4b98-98d8-31432ed46cad	\N	registration-terms-and-conditions	62548a37-f59d-45a0-adc9-27061011b0f3	9ba76793-3bc5-4c14-a196-9f2582f310fb	3	70	f	\N	\N
74a09071-8ca3-419c-ba49-330e57ea8494	\N	reset-credentials-choose-user	62548a37-f59d-45a0-adc9-27061011b0f3	4119f2bc-fc86-4563-864b-42878875f4c0	0	10	f	\N	\N
e8097abd-8532-4bcc-8822-bf0741ac8529	\N	reset-credential-email	62548a37-f59d-45a0-adc9-27061011b0f3	4119f2bc-fc86-4563-864b-42878875f4c0	0	20	f	\N	\N
baf2ef24-d709-44f1-bd6d-b37dc3a5be6f	\N	reset-password	62548a37-f59d-45a0-adc9-27061011b0f3	4119f2bc-fc86-4563-864b-42878875f4c0	0	30	f	\N	\N
6f9679c6-4639-49f8-97a5-3336dd60a2db	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	4119f2bc-fc86-4563-864b-42878875f4c0	1	40	t	a0093d1c-98bd-43bb-b72f-76af056aa90e	\N
c1680c8e-ba07-47c0-927f-483446e32b95	\N	conditional-user-configured	62548a37-f59d-45a0-adc9-27061011b0f3	a0093d1c-98bd-43bb-b72f-76af056aa90e	0	10	f	\N	\N
8ab6e3b0-e961-4849-bc6a-60618affdcfa	\N	reset-otp	62548a37-f59d-45a0-adc9-27061011b0f3	a0093d1c-98bd-43bb-b72f-76af056aa90e	0	20	f	\N	\N
51c0aa9b-8b42-4d9e-8729-ce33fa73efca	\N	client-secret	62548a37-f59d-45a0-adc9-27061011b0f3	33eec804-68e5-46fd-a512-7e62146cb455	2	10	f	\N	\N
447e8a63-0e12-4a52-bf42-ad9819da6559	\N	client-jwt	62548a37-f59d-45a0-adc9-27061011b0f3	33eec804-68e5-46fd-a512-7e62146cb455	2	20	f	\N	\N
f720d997-7cf1-45be-a0e7-18f50f5b3566	\N	client-secret-jwt	62548a37-f59d-45a0-adc9-27061011b0f3	33eec804-68e5-46fd-a512-7e62146cb455	2	30	f	\N	\N
392dd98e-b565-4ba3-87b4-1ae6e537777e	\N	client-x509	62548a37-f59d-45a0-adc9-27061011b0f3	33eec804-68e5-46fd-a512-7e62146cb455	2	40	f	\N	\N
bb98eb0a-bb01-4e3f-9acf-05d2800f3295	\N	idp-review-profile	62548a37-f59d-45a0-adc9-27061011b0f3	c5de7363-3d60-4a91-ac3a-f4e477354f89	0	10	f	\N	247b2a22-cbb2-4eea-8bf9-65e8e5d81ed0
a5b0aae0-5f45-413b-8ec9-000a0819ddee	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	c5de7363-3d60-4a91-ac3a-f4e477354f89	0	20	t	85d4e260-0415-41d1-b8a8-4517d6c5ffd1	\N
7302bd08-ad60-4b8c-9bcb-0e0e1f262f0e	\N	idp-create-user-if-unique	62548a37-f59d-45a0-adc9-27061011b0f3	85d4e260-0415-41d1-b8a8-4517d6c5ffd1	2	10	f	\N	0b41c307-878e-4594-b929-7eac929c7ddb
04a5409f-b646-42f5-99f7-8e7bece350f0	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	85d4e260-0415-41d1-b8a8-4517d6c5ffd1	2	20	t	3a236572-0570-4dc9-865e-97cdf1e89422	\N
aa592a81-8322-43c4-a510-cd2dfcacef2f	\N	idp-confirm-link	62548a37-f59d-45a0-adc9-27061011b0f3	3a236572-0570-4dc9-865e-97cdf1e89422	0	10	f	\N	\N
c96f46ec-00b6-442f-9f41-32cbdde2d275	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	3a236572-0570-4dc9-865e-97cdf1e89422	0	20	t	3dccfd26-f1a0-4e8a-9916-9e41b791d547	\N
731151c7-cad3-4e63-97cf-6ae212103061	\N	idp-email-verification	62548a37-f59d-45a0-adc9-27061011b0f3	3dccfd26-f1a0-4e8a-9916-9e41b791d547	2	10	f	\N	\N
7e9d2548-4012-4148-83ba-93dcae8466b1	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	3dccfd26-f1a0-4e8a-9916-9e41b791d547	2	20	t	441b157c-9a59-498a-9503-42701f3314c4	\N
0ebb73d0-490f-4953-a030-ab07e5429105	\N	idp-username-password-form	62548a37-f59d-45a0-adc9-27061011b0f3	441b157c-9a59-498a-9503-42701f3314c4	0	10	f	\N	\N
aa4d06c4-d5bb-4e38-b0aa-772a6c3d5e2e	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	441b157c-9a59-498a-9503-42701f3314c4	1	20	t	a5babf76-05f9-4f56-a8f6-a5fdeafe3ec2	\N
89faad28-e4cf-4aee-b5f5-dc5612da2b08	\N	conditional-user-configured	62548a37-f59d-45a0-adc9-27061011b0f3	a5babf76-05f9-4f56-a8f6-a5fdeafe3ec2	0	10	f	\N	\N
e748df86-5ad8-412a-9dfd-d509075e4979	\N	auth-otp-form	62548a37-f59d-45a0-adc9-27061011b0f3	a5babf76-05f9-4f56-a8f6-a5fdeafe3ec2	0	20	f	\N	\N
0e894829-4ff9-425f-b17e-2ec8e8fd03e8	\N	http-basic-authenticator	62548a37-f59d-45a0-adc9-27061011b0f3	13b4edcb-e9a1-499f-a54e-a5b419a4f94f	0	10	f	\N	\N
454a32b0-b570-496c-84a0-6cda0fcb6f41	\N	docker-http-basic-authenticator	62548a37-f59d-45a0-adc9-27061011b0f3	23fe7204-25aa-4c94-b62c-fb84bf755542	0	10	f	\N	\N
8f765ad9-4e70-4ef9-8607-4b73ea63cf38	\N	auth-cookie	82225a6e-13a1-44cf-a86f-129f1a907c0b	538905a2-b036-4dff-a7d5-1ee5c0925f1d	2	10	f	\N	\N
383cd5f1-e85a-4597-a1a6-ba75ed4c71e0	\N	auth-spnego	82225a6e-13a1-44cf-a86f-129f1a907c0b	538905a2-b036-4dff-a7d5-1ee5c0925f1d	3	20	f	\N	\N
1b5ae6fc-47a4-435c-a5d0-32a3c7352c10	\N	identity-provider-redirector	82225a6e-13a1-44cf-a86f-129f1a907c0b	538905a2-b036-4dff-a7d5-1ee5c0925f1d	2	25	f	\N	\N
8f524b1e-b05e-4d1e-ade5-f0106d82e6ee	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	538905a2-b036-4dff-a7d5-1ee5c0925f1d	2	30	t	bf25dc37-7db6-4ec0-ac3d-eee24afec289	\N
13176eb4-78f8-4cc8-a255-4a7d7ef714a7	\N	auth-username-password-form	82225a6e-13a1-44cf-a86f-129f1a907c0b	bf25dc37-7db6-4ec0-ac3d-eee24afec289	0	10	f	\N	\N
0bfc544b-84dc-4d65-b9f8-d0bc92c8e684	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	bf25dc37-7db6-4ec0-ac3d-eee24afec289	1	20	t	abd9f74e-686a-4a2a-91d0-803aae4cac60	\N
bca4906c-cabb-47c3-8fa0-3c9d9f3dc835	\N	conditional-user-configured	82225a6e-13a1-44cf-a86f-129f1a907c0b	abd9f74e-686a-4a2a-91d0-803aae4cac60	0	10	f	\N	\N
7ee53ec8-f18d-4283-ad1d-4ec8d0577eee	\N	auth-otp-form	82225a6e-13a1-44cf-a86f-129f1a907c0b	abd9f74e-686a-4a2a-91d0-803aae4cac60	0	20	f	\N	\N
43db0d7e-ce52-451a-89da-8677ded64be8	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	538905a2-b036-4dff-a7d5-1ee5c0925f1d	2	26	t	0e4ff9f6-9167-4e63-9ec8-f89be3b6f1fb	\N
b1989ca7-1c88-42f1-9980-3cb4d12a0505	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	0e4ff9f6-9167-4e63-9ec8-f89be3b6f1fb	1	10	t	6dafa3b8-5323-47f4-b3ae-355d8d7067f2	\N
9f2b039a-5034-4643-ab0f-bb3f941a233a	\N	conditional-user-configured	82225a6e-13a1-44cf-a86f-129f1a907c0b	6dafa3b8-5323-47f4-b3ae-355d8d7067f2	0	10	f	\N	\N
ed6b8ef2-72e2-4546-9afc-0b88bfc6a82a	\N	organization	82225a6e-13a1-44cf-a86f-129f1a907c0b	6dafa3b8-5323-47f4-b3ae-355d8d7067f2	2	20	f	\N	\N
7e1598d5-b62f-445f-81dd-55041f8c014b	\N	direct-grant-validate-username	82225a6e-13a1-44cf-a86f-129f1a907c0b	f6d772c3-220e-4f81-ba59-1c5b848b40d7	0	10	f	\N	\N
f9c08e46-9d08-4aa4-a187-77da8df359c6	\N	direct-grant-validate-password	82225a6e-13a1-44cf-a86f-129f1a907c0b	f6d772c3-220e-4f81-ba59-1c5b848b40d7	0	20	f	\N	\N
056578ae-bacd-486b-a345-46505d24f5f0	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	f6d772c3-220e-4f81-ba59-1c5b848b40d7	1	30	t	87ea26c5-a902-4fb0-907b-b38751c5e1c1	\N
c6e6c780-981e-4b2d-8133-bfac00df81cf	\N	conditional-user-configured	82225a6e-13a1-44cf-a86f-129f1a907c0b	87ea26c5-a902-4fb0-907b-b38751c5e1c1	0	10	f	\N	\N
43577c3c-8253-4912-afae-d0c630e8bd9e	\N	direct-grant-validate-otp	82225a6e-13a1-44cf-a86f-129f1a907c0b	87ea26c5-a902-4fb0-907b-b38751c5e1c1	0	20	f	\N	\N
d2b6e3b1-6aa8-4d22-89dc-f93b54fb6acb	\N	registration-page-form	82225a6e-13a1-44cf-a86f-129f1a907c0b	ba3d4c6b-fd2f-4cd9-a5f2-29484f732a61	0	10	t	e561d04b-30c0-4588-ab85-d1c8d6c2325e	\N
69e22d91-cc12-4b8e-8968-04f88cd345bf	\N	registration-user-creation	82225a6e-13a1-44cf-a86f-129f1a907c0b	e561d04b-30c0-4588-ab85-d1c8d6c2325e	0	20	f	\N	\N
65cdb7cb-bd47-4642-b7f9-698564111370	\N	registration-password-action	82225a6e-13a1-44cf-a86f-129f1a907c0b	e561d04b-30c0-4588-ab85-d1c8d6c2325e	0	50	f	\N	\N
0192b50c-be7a-465d-9f26-6dbaa10258ef	\N	registration-recaptcha-action	82225a6e-13a1-44cf-a86f-129f1a907c0b	e561d04b-30c0-4588-ab85-d1c8d6c2325e	3	60	f	\N	\N
42c04b2c-eca5-4c06-a44b-24ec7ccba20f	\N	registration-terms-and-conditions	82225a6e-13a1-44cf-a86f-129f1a907c0b	e561d04b-30c0-4588-ab85-d1c8d6c2325e	3	70	f	\N	\N
575abd90-f3fd-4f05-b562-42adfdc7a640	\N	reset-credentials-choose-user	82225a6e-13a1-44cf-a86f-129f1a907c0b	6b8630ce-2b50-46a0-8eb3-35ce0f137577	0	10	f	\N	\N
53ec59b9-6803-46a7-bb45-79b82e9c9662	\N	reset-credential-email	82225a6e-13a1-44cf-a86f-129f1a907c0b	6b8630ce-2b50-46a0-8eb3-35ce0f137577	0	20	f	\N	\N
5d533732-1aae-4922-8df8-1ac7a3ea296a	\N	reset-password	82225a6e-13a1-44cf-a86f-129f1a907c0b	6b8630ce-2b50-46a0-8eb3-35ce0f137577	0	30	f	\N	\N
2e0b07d4-243e-4141-83e4-6ab6dbcaa873	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	6b8630ce-2b50-46a0-8eb3-35ce0f137577	1	40	t	1a1ead11-515a-4854-915d-42d46079a8a1	\N
c7e8cb9c-8bdc-4d2a-b65b-9dd1b409d011	\N	conditional-user-configured	82225a6e-13a1-44cf-a86f-129f1a907c0b	1a1ead11-515a-4854-915d-42d46079a8a1	0	10	f	\N	\N
bd783d62-302d-4413-ab18-02223b698084	\N	reset-otp	82225a6e-13a1-44cf-a86f-129f1a907c0b	1a1ead11-515a-4854-915d-42d46079a8a1	0	20	f	\N	\N
19d2bc94-ffd0-409c-b536-51fb013ed17c	\N	client-secret	82225a6e-13a1-44cf-a86f-129f1a907c0b	3fdd4a2a-426e-48d6-be02-55d72931ccdc	2	10	f	\N	\N
411402ee-b01a-4223-8e1c-7996a1c16f41	\N	client-jwt	82225a6e-13a1-44cf-a86f-129f1a907c0b	3fdd4a2a-426e-48d6-be02-55d72931ccdc	2	20	f	\N	\N
73a8d7fb-f463-4e51-b20d-291988c41044	\N	client-secret-jwt	82225a6e-13a1-44cf-a86f-129f1a907c0b	3fdd4a2a-426e-48d6-be02-55d72931ccdc	2	30	f	\N	\N
63abaa1c-d6ee-435b-8bcf-a279a0d43285	\N	client-x509	82225a6e-13a1-44cf-a86f-129f1a907c0b	3fdd4a2a-426e-48d6-be02-55d72931ccdc	2	40	f	\N	\N
cda0039f-3843-4164-bcee-346abe0d3fa0	\N	idp-review-profile	82225a6e-13a1-44cf-a86f-129f1a907c0b	ed7872c1-7f43-432a-a08c-1ce740b43000	0	10	f	\N	e5cb5ded-2725-465b-a481-701228a23932
ed17139d-448e-425c-a391-ee06042820c8	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	ed7872c1-7f43-432a-a08c-1ce740b43000	0	20	t	20fb9824-1674-4f2e-9c91-7435b2dfd508	\N
ec85db93-d4ee-48dd-9f2d-285b31cac9ba	\N	idp-create-user-if-unique	82225a6e-13a1-44cf-a86f-129f1a907c0b	20fb9824-1674-4f2e-9c91-7435b2dfd508	2	10	f	\N	1a0c63f1-e3d9-428c-b716-67ff95f4ce28
b866313f-d3d2-4d79-9661-769621fc79f6	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	20fb9824-1674-4f2e-9c91-7435b2dfd508	2	20	t	e3f3bbc4-b17b-4cfd-a972-6c453f788cbd	\N
dbf788e2-42dc-4722-ab37-00677f00044f	\N	idp-confirm-link	82225a6e-13a1-44cf-a86f-129f1a907c0b	e3f3bbc4-b17b-4cfd-a972-6c453f788cbd	0	10	f	\N	\N
baa588e7-a905-41be-9c46-9a1fff526416	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	e3f3bbc4-b17b-4cfd-a972-6c453f788cbd	0	20	t	8f88ffd2-a0b0-40aa-99fe-6f455cd9910d	\N
05110327-e32c-4718-bf1c-fa16b44013c4	\N	idp-email-verification	82225a6e-13a1-44cf-a86f-129f1a907c0b	8f88ffd2-a0b0-40aa-99fe-6f455cd9910d	2	10	f	\N	\N
8c0d3892-9b32-4a65-9494-107d744374b9	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	8f88ffd2-a0b0-40aa-99fe-6f455cd9910d	2	20	t	97b460b0-1d98-4258-8011-d5bb8134547b	\N
a78721bb-f919-4041-a294-9e96e27029f4	\N	idp-username-password-form	82225a6e-13a1-44cf-a86f-129f1a907c0b	97b460b0-1d98-4258-8011-d5bb8134547b	0	10	f	\N	\N
7a8881a2-ffe2-435f-b1d8-12e56b33bbe5	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	97b460b0-1d98-4258-8011-d5bb8134547b	1	20	t	fee6a006-9d07-47dd-9c34-43caab8eea21	\N
eec08a62-7cbb-42aa-83c0-dc03b60b354d	\N	conditional-user-configured	82225a6e-13a1-44cf-a86f-129f1a907c0b	fee6a006-9d07-47dd-9c34-43caab8eea21	0	10	f	\N	\N
0c2db8d3-cd3b-4202-851a-8bb495b56305	\N	auth-otp-form	82225a6e-13a1-44cf-a86f-129f1a907c0b	fee6a006-9d07-47dd-9c34-43caab8eea21	0	20	f	\N	\N
53274a5c-1e37-48be-8c52-ca2c0b21615f	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	ed7872c1-7f43-432a-a08c-1ce740b43000	1	50	t	64ad7e09-8916-4de1-9309-bcf83920b01b	\N
ab1d041c-e72d-40d2-ba3c-01e3d881d854	\N	conditional-user-configured	82225a6e-13a1-44cf-a86f-129f1a907c0b	64ad7e09-8916-4de1-9309-bcf83920b01b	0	10	f	\N	\N
09f25716-1aad-4472-b259-43481d9dd79b	\N	idp-add-organization-member	82225a6e-13a1-44cf-a86f-129f1a907c0b	64ad7e09-8916-4de1-9309-bcf83920b01b	0	20	f	\N	\N
bfa9263d-6633-412b-ad38-5e4d5532420e	\N	http-basic-authenticator	82225a6e-13a1-44cf-a86f-129f1a907c0b	1c1b7b69-c224-47cc-9937-061971c2f879	0	10	f	\N	\N
b6019c6a-6017-48e6-8258-5e9c6cdb5c76	\N	docker-http-basic-authenticator	82225a6e-13a1-44cf-a86f-129f1a907c0b	da879fd4-5cd9-4699-b679-ae0b24fad1bd	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
f616f338-c4c6-423d-ae7f-96f394153f27	browser	Browser based authentication	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	t	t
8d4f6c49-9328-4a3d-8d04-c69fd324c71e	forms	Username, password, otp and other auth forms.	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
838932c5-419b-401b-934e-e37cb8e824ed	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
dc77fc60-7c97-4461-9ff1-9c688e1cb1f6	direct grant	OpenID Connect Resource Owner Grant	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	t	t
cba65c95-5244-4a8d-bcec-5c5ffce70d5d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
151a8c2d-0e03-4aa2-8f42-3d49b50b366d	registration	Registration flow	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	t	t
9ba76793-3bc5-4c14-a196-9f2582f310fb	registration form	Registration form	62548a37-f59d-45a0-adc9-27061011b0f3	form-flow	f	t
4119f2bc-fc86-4563-864b-42878875f4c0	reset credentials	Reset credentials for a user if they forgot their password or something	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	t	t
a0093d1c-98bd-43bb-b72f-76af056aa90e	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
33eec804-68e5-46fd-a512-7e62146cb455	clients	Base authentication for clients	62548a37-f59d-45a0-adc9-27061011b0f3	client-flow	t	t
c5de7363-3d60-4a91-ac3a-f4e477354f89	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	t	t
85d4e260-0415-41d1-b8a8-4517d6c5ffd1	User creation or linking	Flow for the existing/non-existing user alternatives	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
3a236572-0570-4dc9-865e-97cdf1e89422	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
3dccfd26-f1a0-4e8a-9916-9e41b791d547	Account verification options	Method with which to verity the existing account	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
441b157c-9a59-498a-9503-42701f3314c4	Verify Existing Account by Re-authentication	Reauthentication of existing account	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
a5babf76-05f9-4f56-a8f6-a5fdeafe3ec2	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	f	t
13b4edcb-e9a1-499f-a54e-a5b419a4f94f	saml ecp	SAML ECP Profile Authentication Flow	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	t	t
23fe7204-25aa-4c94-b62c-fb84bf755542	docker auth	Used by Docker clients to authenticate against the IDP	62548a37-f59d-45a0-adc9-27061011b0f3	basic-flow	t	t
538905a2-b036-4dff-a7d5-1ee5c0925f1d	browser	Browser based authentication	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	t	t
bf25dc37-7db6-4ec0-ac3d-eee24afec289	forms	Username, password, otp and other auth forms.	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
abd9f74e-686a-4a2a-91d0-803aae4cac60	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
0e4ff9f6-9167-4e63-9ec8-f89be3b6f1fb	Organization	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
6dafa3b8-5323-47f4-b3ae-355d8d7067f2	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
f6d772c3-220e-4f81-ba59-1c5b848b40d7	direct grant	OpenID Connect Resource Owner Grant	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	t	t
87ea26c5-a902-4fb0-907b-b38751c5e1c1	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
ba3d4c6b-fd2f-4cd9-a5f2-29484f732a61	registration	Registration flow	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	t	t
e561d04b-30c0-4588-ab85-d1c8d6c2325e	registration form	Registration form	82225a6e-13a1-44cf-a86f-129f1a907c0b	form-flow	f	t
6b8630ce-2b50-46a0-8eb3-35ce0f137577	reset credentials	Reset credentials for a user if they forgot their password or something	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	t	t
1a1ead11-515a-4854-915d-42d46079a8a1	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
3fdd4a2a-426e-48d6-be02-55d72931ccdc	clients	Base authentication for clients	82225a6e-13a1-44cf-a86f-129f1a907c0b	client-flow	t	t
ed7872c1-7f43-432a-a08c-1ce740b43000	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	t	t
20fb9824-1674-4f2e-9c91-7435b2dfd508	User creation or linking	Flow for the existing/non-existing user alternatives	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
e3f3bbc4-b17b-4cfd-a972-6c453f788cbd	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
8f88ffd2-a0b0-40aa-99fe-6f455cd9910d	Account verification options	Method with which to verity the existing account	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
97b460b0-1d98-4258-8011-d5bb8134547b	Verify Existing Account by Re-authentication	Reauthentication of existing account	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
fee6a006-9d07-47dd-9c34-43caab8eea21	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
64ad7e09-8916-4de1-9309-bcf83920b01b	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	f	t
1c1b7b69-c224-47cc-9937-061971c2f879	saml ecp	SAML ECP Profile Authentication Flow	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	t	t
da879fd4-5cd9-4699-b679-ae0b24fad1bd	docker auth	Used by Docker clients to authenticate against the IDP	82225a6e-13a1-44cf-a86f-129f1a907c0b	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
247b2a22-cbb2-4eea-8bf9-65e8e5d81ed0	review profile config	62548a37-f59d-45a0-adc9-27061011b0f3
0b41c307-878e-4594-b929-7eac929c7ddb	create unique user config	62548a37-f59d-45a0-adc9-27061011b0f3
e5cb5ded-2725-465b-a481-701228a23932	review profile config	82225a6e-13a1-44cf-a86f-129f1a907c0b
1a0c63f1-e3d9-428c-b716-67ff95f4ce28	create unique user config	82225a6e-13a1-44cf-a86f-129f1a907c0b
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0b41c307-878e-4594-b929-7eac929c7ddb	false	require.password.update.after.registration
247b2a22-cbb2-4eea-8bf9-65e8e5d81ed0	missing	update.profile.on.first.login
1a0c63f1-e3d9-428c-b716-67ff95f4ce28	false	require.password.update.after.registration
e5cb5ded-2725-465b-a481-701228a23932	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
ad33cbcc-60d2-4d26-9439-45956e8095fc	t	f	master-realm	0	f	\N	\N	t	\N	f	62548a37-f59d-45a0-adc9-27061011b0f3	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	62548a37-f59d-45a0-adc9-27061011b0f3	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d8fcc746-02b4-40c5-8868-ab2ad6036800	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	62548a37-f59d-45a0-adc9-27061011b0f3	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d28705a5-b340-4235-818e-eab82bd5b299	t	f	broker	0	f	\N	\N	t	\N	f	62548a37-f59d-45a0-adc9-27061011b0f3	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
ec343f09-000f-4118-bd65-b627552fda3d	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	62548a37-f59d-45a0-adc9-27061011b0f3	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
c2fa0097-5920-4f45-9daa-82c29742e223	t	t	admin-cli	0	t	\N	\N	f	\N	f	62548a37-f59d-45a0-adc9-27061011b0f3	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	f	individuals-realm	0	f	\N	\N	t	\N	f	62548a37-f59d-45a0-adc9-27061011b0f3	\N	0	f	f	individuals Realm	f	client-secret	\N	\N	\N	t	f	f	f
be77b0c4-7221-4f71-ad76-35d75b8c654f	t	f	realm-management	0	f	\N	\N	t	\N	f	82225a6e-13a1-44cf-a86f-129f1a907c0b	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
96a5665e-3543-4736-9605-1cae60ce7016	t	f	account	0	t	\N	/realms/individuals/account/	f	\N	f	82225a6e-13a1-44cf-a86f-129f1a907c0b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	t	f	account-console	0	t	\N	/realms/individuals/account/	f	\N	f	82225a6e-13a1-44cf-a86f-129f1a907c0b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	t	f	broker	0	f	\N	\N	t	\N	f	82225a6e-13a1-44cf-a86f-129f1a907c0b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	t	t	security-admin-console	0	t	\N	/admin/individuals/console/	f	\N	f	82225a6e-13a1-44cf-a86f-129f1a907c0b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d6f070ae-e11a-445c-9408-abd6be932710	t	t	admin-cli	0	t	\N	\N	f	\N	f	82225a6e-13a1-44cf-a86f-129f1a907c0b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	t	t	individuals	0	f	Sv7XYOdgXU27e5tkg84t8FoojF43XQPu	http://localhost:8092/api/v1/auth/me	f	http://localhost:8092	f	82225a6e-13a1-44cf-a86f-129f1a907c0b	openid-connect	-1	t	f	individuals	t	client-secret	http://localhost:8092	individuals	\N	t	f	t	t
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	post.logout.redirect.uris	+
d8fcc746-02b4-40c5-8868-ab2ad6036800	post.logout.redirect.uris	+
d8fcc746-02b4-40c5-8868-ab2ad6036800	pkce.code.challenge.method	S256
ec343f09-000f-4118-bd65-b627552fda3d	post.logout.redirect.uris	+
ec343f09-000f-4118-bd65-b627552fda3d	pkce.code.challenge.method	S256
ec343f09-000f-4118-bd65-b627552fda3d	client.use.lightweight.access.token.enabled	true
c2fa0097-5920-4f45-9daa-82c29742e223	client.use.lightweight.access.token.enabled	true
96a5665e-3543-4736-9605-1cae60ce7016	post.logout.redirect.uris	+
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	post.logout.redirect.uris	+
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	pkce.code.challenge.method	S256
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	post.logout.redirect.uris	+
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	pkce.code.challenge.method	S256
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	client.use.lightweight.access.token.enabled	true
d6f070ae-e11a-445c-9408-abd6be932710	client.use.lightweight.access.token.enabled	true
50d26acd-9eea-4f82-865e-16a8cfc79cff	client.secret.creation.time	1748622367
50d26acd-9eea-4f82-865e-16a8cfc79cff	standard.token.exchange.enabled	false
50d26acd-9eea-4f82-865e-16a8cfc79cff	oauth2.device.authorization.grant.enabled	false
50d26acd-9eea-4f82-865e-16a8cfc79cff	oidc.ciba.grant.enabled	false
50d26acd-9eea-4f82-865e-16a8cfc79cff	backchannel.logout.session.required	true
50d26acd-9eea-4f82-865e-16a8cfc79cff	backchannel.logout.revoke.offline.tokens	false
50d26acd-9eea-4f82-865e-16a8cfc79cff	realm_client	false
50d26acd-9eea-4f82-865e-16a8cfc79cff	display.on.consent.screen	false
50d26acd-9eea-4f82-865e-16a8cfc79cff	frontchannel.logout.session.required	true
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
f47e1b3b-dba0-48d8-9f08-380fc08a7da4	offline_access	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect built-in scope: offline_access	openid-connect
794c3aab-9f27-45a5-8613-7dc9b9c485b6	role_list	62548a37-f59d-45a0-adc9-27061011b0f3	SAML role list	saml
fbeac805-46c1-4c0c-b888-14350cc3e78c	saml_organization	62548a37-f59d-45a0-adc9-27061011b0f3	Organization Membership	saml
f02d3e2f-a9da-4a5b-afad-99efef10d698	profile	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect built-in scope: profile	openid-connect
2b45e628-6369-46df-89fa-e9042f5a457e	email	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect built-in scope: email	openid-connect
e6ba9c8a-0523-4bc0-9538-9d6f1d163788	address	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect built-in scope: address	openid-connect
4a102e67-0efb-4b9a-a57b-acfab803cb5d	phone	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect built-in scope: phone	openid-connect
b29e5458-18da-47d8-8e20-4a171a5052a2	roles	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect scope for add user roles to the access token	openid-connect
dab13b27-f52f-41a1-8f53-ad2af26c0d3f	web-origins	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect scope for add allowed web origins to the access token	openid-connect
d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	microprofile-jwt	62548a37-f59d-45a0-adc9-27061011b0f3	Microprofile - JWT built-in scope	openid-connect
087ac527-3963-40c1-b20a-84fe86b5c899	acr	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
889faf51-875f-472a-8930-c6613ea92830	basic	62548a37-f59d-45a0-adc9-27061011b0f3	OpenID Connect scope for add all basic claims to the token	openid-connect
ec6b397e-a1a6-4465-bc66-ce27dce27167	service_account	62548a37-f59d-45a0-adc9-27061011b0f3	Specific scope for a client enabled for service accounts	openid-connect
3c136d62-b309-4deb-8c5d-b3a1bbf6609b	organization	62548a37-f59d-45a0-adc9-27061011b0f3	Additional claims about the organization a subject belongs to	openid-connect
1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	offline_access	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect built-in scope: offline_access	openid-connect
df87aad3-f4e1-4aef-8ebf-7fb18de4a784	role_list	82225a6e-13a1-44cf-a86f-129f1a907c0b	SAML role list	saml
2eefd1ab-3338-4c3d-bc54-83473ba793a8	saml_organization	82225a6e-13a1-44cf-a86f-129f1a907c0b	Organization Membership	saml
b917d452-4c45-457e-873c-00dd6bede814	profile	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect built-in scope: profile	openid-connect
dd296046-122a-456c-89c1-4f7b700f2d45	email	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect built-in scope: email	openid-connect
99cb8783-2390-4c1e-83c4-3acaf2f88161	address	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect built-in scope: address	openid-connect
30ed3d1a-3659-48b3-8346-a99f8be722ba	phone	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect built-in scope: phone	openid-connect
75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	roles	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect scope for add user roles to the access token	openid-connect
6901958b-38f5-4c68-9cc6-d21f08f6ac94	web-origins	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9a1c25b9-bf01-4bac-8450-cd12a260707b	microprofile-jwt	82225a6e-13a1-44cf-a86f-129f1a907c0b	Microprofile - JWT built-in scope	openid-connect
9616f400-cc03-4a5f-acd2-77cac11bb83d	acr	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
4aac8814-2819-4331-a1e4-873f044c640b	basic	82225a6e-13a1-44cf-a86f-129f1a907c0b	OpenID Connect scope for add all basic claims to the token	openid-connect
28213ce9-eb37-40c1-b149-21114f6cc28b	service_account	82225a6e-13a1-44cf-a86f-129f1a907c0b	Specific scope for a client enabled for service accounts	openid-connect
efcc3a03-bf40-4fbe-855f-ab6c9856ad07	organization	82225a6e-13a1-44cf-a86f-129f1a907c0b	Additional claims about the organization a subject belongs to	openid-connect
065f0853-4f27-416d-8c3c-357a42864a3f	individuals	82225a6e-13a1-44cf-a86f-129f1a907c0b	individuals	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
f47e1b3b-dba0-48d8-9f08-380fc08a7da4	true	display.on.consent.screen
f47e1b3b-dba0-48d8-9f08-380fc08a7da4	${offlineAccessScopeConsentText}	consent.screen.text
794c3aab-9f27-45a5-8613-7dc9b9c485b6	true	display.on.consent.screen
794c3aab-9f27-45a5-8613-7dc9b9c485b6	${samlRoleListScopeConsentText}	consent.screen.text
fbeac805-46c1-4c0c-b888-14350cc3e78c	false	display.on.consent.screen
f02d3e2f-a9da-4a5b-afad-99efef10d698	true	display.on.consent.screen
f02d3e2f-a9da-4a5b-afad-99efef10d698	${profileScopeConsentText}	consent.screen.text
f02d3e2f-a9da-4a5b-afad-99efef10d698	true	include.in.token.scope
2b45e628-6369-46df-89fa-e9042f5a457e	true	display.on.consent.screen
2b45e628-6369-46df-89fa-e9042f5a457e	${emailScopeConsentText}	consent.screen.text
2b45e628-6369-46df-89fa-e9042f5a457e	true	include.in.token.scope
e6ba9c8a-0523-4bc0-9538-9d6f1d163788	true	display.on.consent.screen
e6ba9c8a-0523-4bc0-9538-9d6f1d163788	${addressScopeConsentText}	consent.screen.text
e6ba9c8a-0523-4bc0-9538-9d6f1d163788	true	include.in.token.scope
4a102e67-0efb-4b9a-a57b-acfab803cb5d	true	display.on.consent.screen
4a102e67-0efb-4b9a-a57b-acfab803cb5d	${phoneScopeConsentText}	consent.screen.text
4a102e67-0efb-4b9a-a57b-acfab803cb5d	true	include.in.token.scope
b29e5458-18da-47d8-8e20-4a171a5052a2	true	display.on.consent.screen
b29e5458-18da-47d8-8e20-4a171a5052a2	${rolesScopeConsentText}	consent.screen.text
b29e5458-18da-47d8-8e20-4a171a5052a2	false	include.in.token.scope
dab13b27-f52f-41a1-8f53-ad2af26c0d3f	false	display.on.consent.screen
dab13b27-f52f-41a1-8f53-ad2af26c0d3f		consent.screen.text
dab13b27-f52f-41a1-8f53-ad2af26c0d3f	false	include.in.token.scope
d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	false	display.on.consent.screen
d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	true	include.in.token.scope
087ac527-3963-40c1-b20a-84fe86b5c899	false	display.on.consent.screen
087ac527-3963-40c1-b20a-84fe86b5c899	false	include.in.token.scope
889faf51-875f-472a-8930-c6613ea92830	false	display.on.consent.screen
889faf51-875f-472a-8930-c6613ea92830	false	include.in.token.scope
ec6b397e-a1a6-4465-bc66-ce27dce27167	false	display.on.consent.screen
ec6b397e-a1a6-4465-bc66-ce27dce27167	false	include.in.token.scope
3c136d62-b309-4deb-8c5d-b3a1bbf6609b	true	display.on.consent.screen
3c136d62-b309-4deb-8c5d-b3a1bbf6609b	${organizationScopeConsentText}	consent.screen.text
3c136d62-b309-4deb-8c5d-b3a1bbf6609b	true	include.in.token.scope
1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	true	display.on.consent.screen
1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	${offlineAccessScopeConsentText}	consent.screen.text
df87aad3-f4e1-4aef-8ebf-7fb18de4a784	true	display.on.consent.screen
df87aad3-f4e1-4aef-8ebf-7fb18de4a784	${samlRoleListScopeConsentText}	consent.screen.text
2eefd1ab-3338-4c3d-bc54-83473ba793a8	false	display.on.consent.screen
b917d452-4c45-457e-873c-00dd6bede814	true	display.on.consent.screen
b917d452-4c45-457e-873c-00dd6bede814	${profileScopeConsentText}	consent.screen.text
b917d452-4c45-457e-873c-00dd6bede814	true	include.in.token.scope
dd296046-122a-456c-89c1-4f7b700f2d45	true	display.on.consent.screen
dd296046-122a-456c-89c1-4f7b700f2d45	${emailScopeConsentText}	consent.screen.text
dd296046-122a-456c-89c1-4f7b700f2d45	true	include.in.token.scope
99cb8783-2390-4c1e-83c4-3acaf2f88161	true	display.on.consent.screen
99cb8783-2390-4c1e-83c4-3acaf2f88161	${addressScopeConsentText}	consent.screen.text
99cb8783-2390-4c1e-83c4-3acaf2f88161	true	include.in.token.scope
30ed3d1a-3659-48b3-8346-a99f8be722ba	true	display.on.consent.screen
30ed3d1a-3659-48b3-8346-a99f8be722ba	${phoneScopeConsentText}	consent.screen.text
30ed3d1a-3659-48b3-8346-a99f8be722ba	true	include.in.token.scope
75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	true	display.on.consent.screen
75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	${rolesScopeConsentText}	consent.screen.text
75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	false	include.in.token.scope
6901958b-38f5-4c68-9cc6-d21f08f6ac94	false	display.on.consent.screen
6901958b-38f5-4c68-9cc6-d21f08f6ac94		consent.screen.text
6901958b-38f5-4c68-9cc6-d21f08f6ac94	false	include.in.token.scope
9a1c25b9-bf01-4bac-8450-cd12a260707b	false	display.on.consent.screen
9a1c25b9-bf01-4bac-8450-cd12a260707b	true	include.in.token.scope
9616f400-cc03-4a5f-acd2-77cac11bb83d	false	display.on.consent.screen
9616f400-cc03-4a5f-acd2-77cac11bb83d	false	include.in.token.scope
4aac8814-2819-4331-a1e4-873f044c640b	false	display.on.consent.screen
4aac8814-2819-4331-a1e4-873f044c640b	false	include.in.token.scope
28213ce9-eb37-40c1-b149-21114f6cc28b	false	display.on.consent.screen
28213ce9-eb37-40c1-b149-21114f6cc28b	false	include.in.token.scope
efcc3a03-bf40-4fbe-855f-ab6c9856ad07	true	display.on.consent.screen
efcc3a03-bf40-4fbe-855f-ab6c9856ad07	${organizationScopeConsentText}	consent.screen.text
efcc3a03-bf40-4fbe-855f-ab6c9856ad07	true	include.in.token.scope
065f0853-4f27-416d-8c3c-357a42864a3f	true	display.on.consent.screen
065f0853-4f27-416d-8c3c-357a42864a3f		consent.screen.text
065f0853-4f27-416d-8c3c-357a42864a3f	true	include.in.token.scope
065f0853-4f27-416d-8c3c-357a42864a3f		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	087ac527-3963-40c1-b20a-84fe86b5c899	t
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	f02d3e2f-a9da-4a5b-afad-99efef10d698	t
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	2b45e628-6369-46df-89fa-e9042f5a457e	t
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	889faf51-875f-472a-8930-c6613ea92830	t
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	dab13b27-f52f-41a1-8f53-ad2af26c0d3f	t
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	b29e5458-18da-47d8-8e20-4a171a5052a2	t
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	e6ba9c8a-0523-4bc0-9538-9d6f1d163788	f
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	3c136d62-b309-4deb-8c5d-b3a1bbf6609b	f
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	f47e1b3b-dba0-48d8-9f08-380fc08a7da4	f
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	4a102e67-0efb-4b9a-a57b-acfab803cb5d	f
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	f
d8fcc746-02b4-40c5-8868-ab2ad6036800	087ac527-3963-40c1-b20a-84fe86b5c899	t
d8fcc746-02b4-40c5-8868-ab2ad6036800	f02d3e2f-a9da-4a5b-afad-99efef10d698	t
d8fcc746-02b4-40c5-8868-ab2ad6036800	2b45e628-6369-46df-89fa-e9042f5a457e	t
d8fcc746-02b4-40c5-8868-ab2ad6036800	889faf51-875f-472a-8930-c6613ea92830	t
d8fcc746-02b4-40c5-8868-ab2ad6036800	dab13b27-f52f-41a1-8f53-ad2af26c0d3f	t
d8fcc746-02b4-40c5-8868-ab2ad6036800	b29e5458-18da-47d8-8e20-4a171a5052a2	t
d8fcc746-02b4-40c5-8868-ab2ad6036800	e6ba9c8a-0523-4bc0-9538-9d6f1d163788	f
d8fcc746-02b4-40c5-8868-ab2ad6036800	3c136d62-b309-4deb-8c5d-b3a1bbf6609b	f
d8fcc746-02b4-40c5-8868-ab2ad6036800	f47e1b3b-dba0-48d8-9f08-380fc08a7da4	f
d8fcc746-02b4-40c5-8868-ab2ad6036800	4a102e67-0efb-4b9a-a57b-acfab803cb5d	f
d8fcc746-02b4-40c5-8868-ab2ad6036800	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	f
c2fa0097-5920-4f45-9daa-82c29742e223	087ac527-3963-40c1-b20a-84fe86b5c899	t
c2fa0097-5920-4f45-9daa-82c29742e223	f02d3e2f-a9da-4a5b-afad-99efef10d698	t
c2fa0097-5920-4f45-9daa-82c29742e223	2b45e628-6369-46df-89fa-e9042f5a457e	t
c2fa0097-5920-4f45-9daa-82c29742e223	889faf51-875f-472a-8930-c6613ea92830	t
c2fa0097-5920-4f45-9daa-82c29742e223	dab13b27-f52f-41a1-8f53-ad2af26c0d3f	t
c2fa0097-5920-4f45-9daa-82c29742e223	b29e5458-18da-47d8-8e20-4a171a5052a2	t
c2fa0097-5920-4f45-9daa-82c29742e223	e6ba9c8a-0523-4bc0-9538-9d6f1d163788	f
c2fa0097-5920-4f45-9daa-82c29742e223	3c136d62-b309-4deb-8c5d-b3a1bbf6609b	f
c2fa0097-5920-4f45-9daa-82c29742e223	f47e1b3b-dba0-48d8-9f08-380fc08a7da4	f
c2fa0097-5920-4f45-9daa-82c29742e223	4a102e67-0efb-4b9a-a57b-acfab803cb5d	f
c2fa0097-5920-4f45-9daa-82c29742e223	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	f
d28705a5-b340-4235-818e-eab82bd5b299	087ac527-3963-40c1-b20a-84fe86b5c899	t
d28705a5-b340-4235-818e-eab82bd5b299	f02d3e2f-a9da-4a5b-afad-99efef10d698	t
d28705a5-b340-4235-818e-eab82bd5b299	2b45e628-6369-46df-89fa-e9042f5a457e	t
d28705a5-b340-4235-818e-eab82bd5b299	889faf51-875f-472a-8930-c6613ea92830	t
d28705a5-b340-4235-818e-eab82bd5b299	dab13b27-f52f-41a1-8f53-ad2af26c0d3f	t
d28705a5-b340-4235-818e-eab82bd5b299	b29e5458-18da-47d8-8e20-4a171a5052a2	t
d28705a5-b340-4235-818e-eab82bd5b299	e6ba9c8a-0523-4bc0-9538-9d6f1d163788	f
d28705a5-b340-4235-818e-eab82bd5b299	3c136d62-b309-4deb-8c5d-b3a1bbf6609b	f
d28705a5-b340-4235-818e-eab82bd5b299	f47e1b3b-dba0-48d8-9f08-380fc08a7da4	f
d28705a5-b340-4235-818e-eab82bd5b299	4a102e67-0efb-4b9a-a57b-acfab803cb5d	f
d28705a5-b340-4235-818e-eab82bd5b299	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	f
ad33cbcc-60d2-4d26-9439-45956e8095fc	087ac527-3963-40c1-b20a-84fe86b5c899	t
ad33cbcc-60d2-4d26-9439-45956e8095fc	f02d3e2f-a9da-4a5b-afad-99efef10d698	t
ad33cbcc-60d2-4d26-9439-45956e8095fc	2b45e628-6369-46df-89fa-e9042f5a457e	t
ad33cbcc-60d2-4d26-9439-45956e8095fc	889faf51-875f-472a-8930-c6613ea92830	t
ad33cbcc-60d2-4d26-9439-45956e8095fc	dab13b27-f52f-41a1-8f53-ad2af26c0d3f	t
ad33cbcc-60d2-4d26-9439-45956e8095fc	b29e5458-18da-47d8-8e20-4a171a5052a2	t
ad33cbcc-60d2-4d26-9439-45956e8095fc	e6ba9c8a-0523-4bc0-9538-9d6f1d163788	f
ad33cbcc-60d2-4d26-9439-45956e8095fc	3c136d62-b309-4deb-8c5d-b3a1bbf6609b	f
ad33cbcc-60d2-4d26-9439-45956e8095fc	f47e1b3b-dba0-48d8-9f08-380fc08a7da4	f
ad33cbcc-60d2-4d26-9439-45956e8095fc	4a102e67-0efb-4b9a-a57b-acfab803cb5d	f
ad33cbcc-60d2-4d26-9439-45956e8095fc	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	f
ec343f09-000f-4118-bd65-b627552fda3d	087ac527-3963-40c1-b20a-84fe86b5c899	t
ec343f09-000f-4118-bd65-b627552fda3d	f02d3e2f-a9da-4a5b-afad-99efef10d698	t
ec343f09-000f-4118-bd65-b627552fda3d	2b45e628-6369-46df-89fa-e9042f5a457e	t
ec343f09-000f-4118-bd65-b627552fda3d	889faf51-875f-472a-8930-c6613ea92830	t
ec343f09-000f-4118-bd65-b627552fda3d	dab13b27-f52f-41a1-8f53-ad2af26c0d3f	t
ec343f09-000f-4118-bd65-b627552fda3d	b29e5458-18da-47d8-8e20-4a171a5052a2	t
ec343f09-000f-4118-bd65-b627552fda3d	e6ba9c8a-0523-4bc0-9538-9d6f1d163788	f
ec343f09-000f-4118-bd65-b627552fda3d	3c136d62-b309-4deb-8c5d-b3a1bbf6609b	f
ec343f09-000f-4118-bd65-b627552fda3d	f47e1b3b-dba0-48d8-9f08-380fc08a7da4	f
ec343f09-000f-4118-bd65-b627552fda3d	4a102e67-0efb-4b9a-a57b-acfab803cb5d	f
ec343f09-000f-4118-bd65-b627552fda3d	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	f
96a5665e-3543-4736-9605-1cae60ce7016	4aac8814-2819-4331-a1e4-873f044c640b	t
96a5665e-3543-4736-9605-1cae60ce7016	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
96a5665e-3543-4736-9605-1cae60ce7016	b917d452-4c45-457e-873c-00dd6bede814	t
96a5665e-3543-4736-9605-1cae60ce7016	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
96a5665e-3543-4736-9605-1cae60ce7016	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
96a5665e-3543-4736-9605-1cae60ce7016	dd296046-122a-456c-89c1-4f7b700f2d45	t
96a5665e-3543-4736-9605-1cae60ce7016	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
96a5665e-3543-4736-9605-1cae60ce7016	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
96a5665e-3543-4736-9605-1cae60ce7016	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
96a5665e-3543-4736-9605-1cae60ce7016	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
96a5665e-3543-4736-9605-1cae60ce7016	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	4aac8814-2819-4331-a1e4-873f044c640b	t
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	b917d452-4c45-457e-873c-00dd6bede814	t
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	dd296046-122a-456c-89c1-4f7b700f2d45	t
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
d6f070ae-e11a-445c-9408-abd6be932710	4aac8814-2819-4331-a1e4-873f044c640b	t
d6f070ae-e11a-445c-9408-abd6be932710	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
d6f070ae-e11a-445c-9408-abd6be932710	b917d452-4c45-457e-873c-00dd6bede814	t
d6f070ae-e11a-445c-9408-abd6be932710	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
d6f070ae-e11a-445c-9408-abd6be932710	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
d6f070ae-e11a-445c-9408-abd6be932710	dd296046-122a-456c-89c1-4f7b700f2d45	t
d6f070ae-e11a-445c-9408-abd6be932710	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
d6f070ae-e11a-445c-9408-abd6be932710	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
d6f070ae-e11a-445c-9408-abd6be932710	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
d6f070ae-e11a-445c-9408-abd6be932710	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
d6f070ae-e11a-445c-9408-abd6be932710	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	4aac8814-2819-4331-a1e4-873f044c640b	t
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	b917d452-4c45-457e-873c-00dd6bede814	t
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	dd296046-122a-456c-89c1-4f7b700f2d45	t
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
be77b0c4-7221-4f71-ad76-35d75b8c654f	4aac8814-2819-4331-a1e4-873f044c640b	t
be77b0c4-7221-4f71-ad76-35d75b8c654f	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
be77b0c4-7221-4f71-ad76-35d75b8c654f	b917d452-4c45-457e-873c-00dd6bede814	t
be77b0c4-7221-4f71-ad76-35d75b8c654f	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
be77b0c4-7221-4f71-ad76-35d75b8c654f	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
be77b0c4-7221-4f71-ad76-35d75b8c654f	dd296046-122a-456c-89c1-4f7b700f2d45	t
be77b0c4-7221-4f71-ad76-35d75b8c654f	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
be77b0c4-7221-4f71-ad76-35d75b8c654f	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
be77b0c4-7221-4f71-ad76-35d75b8c654f	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
be77b0c4-7221-4f71-ad76-35d75b8c654f	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
be77b0c4-7221-4f71-ad76-35d75b8c654f	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	4aac8814-2819-4331-a1e4-873f044c640b	t
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	b917d452-4c45-457e-873c-00dd6bede814	t
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	dd296046-122a-456c-89c1-4f7b700f2d45	t
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	4aac8814-2819-4331-a1e4-873f044c640b	t
50d26acd-9eea-4f82-865e-16a8cfc79cff	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
50d26acd-9eea-4f82-865e-16a8cfc79cff	b917d452-4c45-457e-873c-00dd6bede814	t
50d26acd-9eea-4f82-865e-16a8cfc79cff	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
50d26acd-9eea-4f82-865e-16a8cfc79cff	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
50d26acd-9eea-4f82-865e-16a8cfc79cff	dd296046-122a-456c-89c1-4f7b700f2d45	t
50d26acd-9eea-4f82-865e-16a8cfc79cff	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	065f0853-4f27-416d-8c3c-357a42864a3f	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
50d26acd-9eea-4f82-865e-16a8cfc79cff	28213ce9-eb37-40c1-b149-21114f6cc28b	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
f47e1b3b-dba0-48d8-9f08-380fc08a7da4	2ad0e73e-3409-4ed3-9038-14600a507f2e
1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	74c0f0f0-d16d-49e5-8990-77615a7edc05
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
bab271c5-8798-40d9-8d72-2e9980a069af	Trusted Hosts	62548a37-f59d-45a0-adc9-27061011b0f3	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	anonymous
8774ef3a-e660-460b-b675-678832550c3f	Consent Required	62548a37-f59d-45a0-adc9-27061011b0f3	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	anonymous
1329ad57-bb56-4529-a487-f80b2f76c1e8	Full Scope Disabled	62548a37-f59d-45a0-adc9-27061011b0f3	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	anonymous
6fd83f9f-1b97-4129-81f4-a2047371a3e5	Max Clients Limit	62548a37-f59d-45a0-adc9-27061011b0f3	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	anonymous
86efd12b-32c8-4a64-9d0c-a0798a616ee5	Allowed Protocol Mapper Types	62548a37-f59d-45a0-adc9-27061011b0f3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	anonymous
b56bdf43-09ad-40cc-8899-95dd4fa06a43	Allowed Client Scopes	62548a37-f59d-45a0-adc9-27061011b0f3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	anonymous
ab32be7b-83ef-4266-a910-f9c0a366df3f	Allowed Protocol Mapper Types	62548a37-f59d-45a0-adc9-27061011b0f3	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	authenticated
9c2a397a-ab21-4144-8142-9560deed92f4	Allowed Client Scopes	62548a37-f59d-45a0-adc9-27061011b0f3	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	authenticated
159faa86-538a-4ff9-94cb-ea37aab6a910	rsa-generated	62548a37-f59d-45a0-adc9-27061011b0f3	rsa-generated	org.keycloak.keys.KeyProvider	62548a37-f59d-45a0-adc9-27061011b0f3	\N
2b08a774-433f-4ccd-bd8f-371325e1506c	rsa-enc-generated	62548a37-f59d-45a0-adc9-27061011b0f3	rsa-enc-generated	org.keycloak.keys.KeyProvider	62548a37-f59d-45a0-adc9-27061011b0f3	\N
be7cb79c-fafb-4886-97b4-7687b2ef1456	hmac-generated-hs512	62548a37-f59d-45a0-adc9-27061011b0f3	hmac-generated	org.keycloak.keys.KeyProvider	62548a37-f59d-45a0-adc9-27061011b0f3	\N
47151db1-c09c-4c13-80d1-17dc523aea90	aes-generated	62548a37-f59d-45a0-adc9-27061011b0f3	aes-generated	org.keycloak.keys.KeyProvider	62548a37-f59d-45a0-adc9-27061011b0f3	\N
079a900b-5687-46e0-a482-383e1ce5fd60	\N	62548a37-f59d-45a0-adc9-27061011b0f3	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	62548a37-f59d-45a0-adc9-27061011b0f3	\N
636a3dcf-fed7-4198-a290-785e32b42806	rsa-generated	82225a6e-13a1-44cf-a86f-129f1a907c0b	rsa-generated	org.keycloak.keys.KeyProvider	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N
2396d2df-1808-4ab2-b86a-af0b66f6c9ec	rsa-enc-generated	82225a6e-13a1-44cf-a86f-129f1a907c0b	rsa-enc-generated	org.keycloak.keys.KeyProvider	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N
6a2dd80c-74e3-4092-a917-b80550a80c64	hmac-generated-hs512	82225a6e-13a1-44cf-a86f-129f1a907c0b	hmac-generated	org.keycloak.keys.KeyProvider	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N
ae3ff935-1240-4af6-85e8-49ac3a5fc4da	aes-generated	82225a6e-13a1-44cf-a86f-129f1a907c0b	aes-generated	org.keycloak.keys.KeyProvider	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N
7c585e63-053b-4738-a99a-382cceb17244	Trusted Hosts	82225a6e-13a1-44cf-a86f-129f1a907c0b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	anonymous
733d8963-cc09-4cbc-ae3a-c5a3c46860b6	Consent Required	82225a6e-13a1-44cf-a86f-129f1a907c0b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	anonymous
2ad5ecc1-af8f-470b-8c5c-8172ac40e74c	Full Scope Disabled	82225a6e-13a1-44cf-a86f-129f1a907c0b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	anonymous
e762e675-dc3c-4f4c-880c-15fd067bf945	Max Clients Limit	82225a6e-13a1-44cf-a86f-129f1a907c0b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	anonymous
71a32f56-244d-4428-ab8d-c811349b637e	Allowed Protocol Mapper Types	82225a6e-13a1-44cf-a86f-129f1a907c0b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	anonymous
24f75c13-c00d-423c-bae6-5bf8e1a5623c	Allowed Client Scopes	82225a6e-13a1-44cf-a86f-129f1a907c0b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	anonymous
6d5b353a-a97a-4cc9-9ab0-d305796a55b6	Allowed Protocol Mapper Types	82225a6e-13a1-44cf-a86f-129f1a907c0b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	authenticated
a4f39e6c-c292-481c-9340-09cffe793429	Allowed Client Scopes	82225a6e-13a1-44cf-a86f-129f1a907c0b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
7332df7f-8e07-4302-9c25-1e341a6cec53	9c2a397a-ab21-4144-8142-9560deed92f4	allow-default-scopes	true
61aa6a70-b778-4c60-8671-246a3b7b9d8e	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5b7182b2-4f5f-4544-a5de-0e96b03e3587	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5e8d37f6-9030-4b30-bc6e-b9cc2379dd76	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d450ea62-9c68-4f09-abd3-23256cea2ad8	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	saml-role-list-mapper
61b6feb8-51da-4493-a31e-4622ce0a8897	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	saml-user-property-mapper
3ef23b4c-5e48-4047-88cb-d304e9eda32d	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	oidc-full-name-mapper
36d1a0fc-871d-4a4e-97e5-e00ba4ef2f47	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	oidc-address-mapper
3ec61544-ff94-4df1-ab31-d3800920ee68	ab32be7b-83ef-4266-a910-f9c0a366df3f	allowed-protocol-mapper-types	saml-user-attribute-mapper
013814e6-756e-471f-81c7-ec216e983a20	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	saml-user-property-mapper
656e7d0a-06e9-4755-b282-59957e9252d4	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	oidc-full-name-mapper
0e8155e7-741f-4678-9e48-1b8c94c0c98f	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6295e5a8-4bb2-474f-bdde-4f1d548778bc	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
61e1787d-143c-4fa0-a518-b02f2ef91b25	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	saml-role-list-mapper
166f9f7d-41d6-4649-b1a6-fd10c2b73cc2	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	saml-user-attribute-mapper
cefa5f88-dc9c-40d6-af84-d7679e117b11	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	oidc-address-mapper
8227d7c4-78c1-4e24-8274-1635b3c3403c	86efd12b-32c8-4a64-9d0c-a0798a616ee5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b3207ac9-9a64-4ae8-9a2d-efa266f1aca6	b56bdf43-09ad-40cc-8899-95dd4fa06a43	allow-default-scopes	true
3b2177f6-95cf-41b3-b0e5-0a441438d7fe	6fd83f9f-1b97-4129-81f4-a2047371a3e5	max-clients	200
bddb6428-afd6-4029-aa72-129bd9efcebf	bab271c5-8798-40d9-8d72-2e9980a069af	host-sending-registration-request-must-match	true
11a574a9-3bda-49b0-8dc3-9506e8d77840	bab271c5-8798-40d9-8d72-2e9980a069af	client-uris-must-match	true
49cbb7ea-efac-46ad-97de-8d2ae5a7764c	be7cb79c-fafb-4886-97b4-7687b2ef1456	priority	100
26368f82-03a6-4e21-a088-ca493796130a	be7cb79c-fafb-4886-97b4-7687b2ef1456	algorithm	HS512
a5cb8fe1-af47-4e6f-baf9-0501a841ffb7	be7cb79c-fafb-4886-97b4-7687b2ef1456	kid	80b9a66f-006c-4a52-9aff-122d6f384edd
ca78e8fb-93cd-423a-b9fb-4bdbf9ab883f	be7cb79c-fafb-4886-97b4-7687b2ef1456	secret	doEzUSgaPb7m9U2mqpmA8OjOKEfrQmcokgjg8C7iyvaWN1W4brJbXb2cZmXgnwoWrYGh3R-GvsW6d_77A21L569ZUioEbanc3Q-WfAl4_7I5KK9Ww7pGGnOzsKBU-Imz2FitDQGpZbPfhZB8AgrO1ygGlxfF_HEMiZr6pBBYBFU
592f240f-2b75-44c4-b405-102a99d8a777	079a900b-5687-46e0-a482-383e1ce5fd60	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
723f9a86-d6ac-433f-b0f7-617c74759b56	47151db1-c09c-4c13-80d1-17dc523aea90	kid	db1ccb07-aea3-490c-8c7d-11a23079b96a
f14369c7-55cf-44af-9500-2866d60d1936	47151db1-c09c-4c13-80d1-17dc523aea90	priority	100
65646c0b-0d40-4a92-a17c-f6d5ebac8e0f	47151db1-c09c-4c13-80d1-17dc523aea90	secret	TgMPMaUiq7OE14kgCskaxA
e0b3dc0e-9bde-4167-bcc5-c1500ea09fa7	159faa86-538a-4ff9-94cb-ea37aab6a910	privateKey	MIIEogIBAAKCAQEA6A/NWlQ/LXAkDPd/wZua4HZ/M+mAjHfKDtG0vW3yFv1PfyhE/E228AtZG9H29ZYYmD2TkYhelNyoSxS9jyvmXwuVo29cSFX4q9vgZhnIkMNlmSis7+HmMfifsto5qKTZTmtA39sfXh4RZ12nRKgwN25yJlvmvM2ACpckHbDbIXuk7Gus+q5OVhL0Tt6kyu/7InBYWikPUqckfK3PWxE1g6COsRaJwJwvJ4fggFUrfLXNSCweCT1pK70QtEFd3v/cNjgI8TXZmSLcLsxWt93sxKUv5WG/zeoOQySC+y72amOa8yboFKCe6SPNfZL2orrEvu8VrpFlvLuZK6lHqDO1EQIDAQABAoIBAAQCleVcNFVILU9ODZaeZkA/u/X9MHv86/BynkFxv2+3Q+LqIrsLasBeKdWJvM9EnzsuQTkQFrZS09OsUZRCSXJWBGl1GK6lUa1CmO+avXUG82AArHBewngVmEjibYGlC55HyzCzHCknstxK6YONtnuWvIE+MFAN6wsDzpt2vWqoLGSf6jNNZfxSGi5czeSUL7PTrVZqQpp/mLdvNE+YLFzmWx//O8fo1elXMc0bfauWVjnur5iHTyoJAER7EpF2X90wgb2ZYidahVkSr+FpVBJ3plc8bWuPTNeCyb3CzmvgV5pEFlH2RGkC+UxWJKP1P2GS3J/rbduLr+3sWyDjHDkCgYEA/eFJEpWSXpWtxXdiPF3nwppwdDT688lSANHS4GcQdnNRWUHU7YaTk5DB6cTmfCIR7gLTCgW3pEYLKSC7M8up4v9vHxHj22EX13cSaGWwyAjP3prYsUV9Dt/LhY7etxM0Y1LNNdvfF9ri4wIGGiTYHahwsUizuVEGIhc2d8qWdnUCgYEA6f/gTCIQOtz4dAVDnKtnUtzodT9hMLoANaGa5/26ALbblEuSlfpf5ymRYB2VnZdyEhIq9TkBJehB1EDTky4isx/evjiU2KQq9XAsjE6DKJ9p/ONImP2VB8tp4vbe18TfFnxdoe9iKflB3PZrwBmLjB2PMB34ZclIZwFlWbNKCK0CgYBZvsy0/BisxN6TwlsAmfV2bl+4RI49pXoOfh28Y9KG/MbR9ZqOiJccf/x8ZbVQRj7uUyNFFLZRJM2HMWHbsnAQpVkjs5BHma/y482nB+ORIsRQnY5iQ/0sR+JLCTEjqG9JeRi/pETdyuuPccS0czfObB/CG8Akj0bKwEfp2ryLjQKBgAH5d8IMs4hbnvkTpktnItsPJCMBIufPWfsZ3v3AJVamNFoe/SCo2TBRKHngJggLZBoE7zncfkb8m7mXxnFCfWZ3iWCfh5oAYKBrjuSsMO0h0zogDNfFpAFJ1R3mKWE2tw8wg3W/WFu0T7r2lVgsnwHSqgek6RiqxyKfX2SPX7uNAoGACDPABrt2xZE8DBThPuHoS+uqUCUQ//ZEBHIuHRSO44VYQc/9fJGieTMO+Tep2wYovg+Ny+U+AJsxA7tj3UkDDTJDtUNOVzJpxYgjLWWaO7UzZEOctg3J+Nf07FBYLOewimfa8uGzR+cuQFFwysSlzLpEEgoqE1jSMecRMy9OSlQ=
4c46f80e-34e0-42c3-83cd-c9aee6a72a1c	159faa86-538a-4ff9-94cb-ea37aab6a910	certificate	MIICmzCCAYMCBgGXF/WX9zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNTI4MTczMjQwWhcNMzUwNTI4MTczNDIwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDoD81aVD8tcCQM93/Bm5rgdn8z6YCMd8oO0bS9bfIW/U9/KET8TbbwC1kb0fb1lhiYPZORiF6U3KhLFL2PK+ZfC5Wjb1xIVfir2+BmGciQw2WZKKzv4eYx+J+y2jmopNlOa0Df2x9eHhFnXadEqDA3bnImW+a8zYAKlyQdsNshe6Tsa6z6rk5WEvRO3qTK7/sicFhaKQ9SpyR8rc9bETWDoI6xFonAnC8nh+CAVSt8tc1ILB4JPWkrvRC0QV3e/9w2OAjxNdmZItwuzFa33ezEpS/lYb/N6g5DJIL7LvZqY5rzJugUoJ7pI819kvaiusS+7xWukWW8u5krqUeoM7URAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAMs1FQyG2EvQskLkLU5+JHuKXbrORt6RzzKfCT5cjmT6sSuj0MxgxSAEonZA/zmfOKkd8JXnXPkg0Hw+CXpUQTVF9EWtREQvr0LNZAXL2rkkEcRT5T2Mvx9ismtAFRsm5bN18ACqwIc76WOCmycAITqpcvvVhtiVxHQ2pLp9vK9n1uLMOpYS2fXJXPmF6kWDhJLWjN6PU6EvK5JHBlXlVtFb4GhO72VQpQ3mWQ4z7gAyc8ci5J9YJf6GEpjPY6vM9JXEgHnrmCaTrCI7IbYQm3jigfBlzAhd0x8JIsiHKWULsLeCR/N48TFU5s4en7bUWGHf53W29i4mBnww268U0X8=
381102eb-8662-4f62-b3fc-28934579405b	159faa86-538a-4ff9-94cb-ea37aab6a910	keyUse	SIG
2dc326f5-b937-471d-bff0-f7b9def780c3	159faa86-538a-4ff9-94cb-ea37aab6a910	priority	100
9cd400c2-30fb-4dc1-80b3-0233f070ef8f	2b08a774-433f-4ccd-bd8f-371325e1506c	certificate	MIICmzCCAYMCBgGXF/WZujANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNTI4MTczMjQxWhcNMzUwNTI4MTczNDIxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2eyjXIg1F8xqiOIOhwnmZ8svLWlzy/qIao+ffBU4q/oyd+lMd9zcQZdHvBgjNe2ezNovtQAoesLF2JE+c2v6eFQo7lFPJGuANoIEcjA2KLwJ2j3+2ybkqR5wAY52mBTReSef4WUbX69xMiFsPh2mL5yFnfhIQMrh049lXql9e5NBDPIblVBZhl1hKnzIORxppzks5vyq5EMLkf1KUqU0QKLYoE04oc/0FfELD///gaieCOcOB8Eq4iGHekZNRD02s/YJI4RPeAsrQ6b5w01Orm0+niWsZrdYxD4VHl9vlWtgGqeDG9m2GXCxNevEbbN52s9+1cYaYYI9hsiszMJMbAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKCmRBLFL/871FIvr6zQNjzI6QjgMHJFkapfZIf2spDtHqGedtenRSgmxBvu6iarLjUJCYVictkCT+V6CuaDf5XtxWye2PNcw6bcj0JQ0rj0PSIqwU3lSnGoaWg/+4rKasTkasj0MO2232WwULqc01zGdMemuxnZMqSt+81lQ5/GThw620DDguDOMZhwKT9s13HBVb3PGpz58M8whaOzIiY4BjkO7L592l1KeQYPSwbVgD3AmXPyQ1gW14iFCRdLLaacUxKRH1qo1rhqP3YBO/PmgOyCqQOU+PE4yrmJJstx8aUiU3q1T89ODDg0mmqBlpvuJsw7qGbFq7n6NDhK/v0=
46e2368e-5ebf-4e0a-acc2-33581903fc56	2b08a774-433f-4ccd-bd8f-371325e1506c	privateKey	MIIEowIBAAKCAQEAtnso1yINRfMaojiDocJ5mfLLy1pc8v6iGqPn3wVOKv6MnfpTHfc3EGXR7wYIzXtnszaL7UAKHrCxdiRPnNr+nhUKO5RTyRrgDaCBHIwNii8Cdo9/tsm5KkecAGOdpgU0Xknn+FlG1+vcTIhbD4dpi+chZ34SEDK4dOPZV6pfXuTQQzyG5VQWYZdYSp8yDkcaac5LOb8quRDC5H9SlKlNECi2KBNOKHP9BXxCw///4GongjnDgfBKuIhh3pGTUQ9NrP2CSOET3gLK0Om+cNNTq5tPp4lrGa3WMQ+FR5fb5VrYBqngxvZthlwsTXrxG2zedrPftXGGmGCPYbIrMzCTGwIDAQABAoIBAAfvfy0r2+vo0IWxc3f7XxJkzpv/R/+BN0d1TUYTkvynqTHNiwPIlmpuIx0D5Cobbb0LaDZfDJGdGXqLxbKKi3wQaiuBHcunEYtGKZc2N/iEZtUFFIa8awL9rjkOG/L2UvquuBnCuCP3q9LgMyWPu/VLjdZUUzDFI+RhbDg1voP/2GnEqC7v5nLC2YQYK8deH5sYVqD059UiH5LI/Kp2CQ2oZPNaoO8780qEIiPHe0L0tMYi49mEDnIg5c492HOL8bYQpPAtNw5KI/LtMQOxqQvbmyEFhGavyvWZSV3LDT7WZlvhins/F30ML518ZlcuLpLEkMDSjpTGr4FX2tPUvRECgYEA8sNnlIDwfK/Qfu5LXDpFhAfhEJcdYYe1dpP+5S+vKfFCbLx5R6gh/kKG1yFuDziXgjIRwvZhX+iA9HDL98I3P/sfkg8w6azZCiYWNGwVaReixqaHC38lyCd2oao1ZFQqbS2A1+X3lxhZ8sHEnvFmNzEZ/19iH15olV9ZMx/JIqcCgYEAwG5PStDjvtKJNFujEmlNq9S6O8bIhOwyGFBziroRWwTmaWujs1YF9NbFkyprONXQ35+XYsbZ1Zjvij/+IodxXGFaKlugyK/jTwiAL+9NkbHp5RuKD3Y5lHg9Lm51aqRxhcU6bZdgri0BRFqqqMrx1hMycQI52p7/USLr6B2A3m0CgYABjVRFM8nV0j3wAdADh+/X10EOHRk3/Wkgl/OiPXrONteo4E+aMK3+9Sftii4s9LyrPWy1pWOb/F2OsoXrUJeP1igug+BZLhy5HuM3dJVydY852+izHx37uJzejbsHqC4ZQpg3SSYbFjHFBo4eQgbYRX0YD+ENuEnM4q4sUIC1swKBgQCHdl/9Q/W/JEiQAh5W3Khf2R3M7M/Futw8/42G0BtdnqJw/eQ8X8dLp1Fomwjl9qbWdWtFjsRUOBgQk6HcPsqPhLzLartR63ex8EME+4n4kW0c6nkTD1/TY512LS4dB2wfBktuUI0vr+DfdJAEyPDbiaINqcp+W0VSoam+Od65NQKBgFTK1URIKuylDzuwXnCjP+e2efeFw2akd6LrRDDvK7HIDErbNywzRSVJMdGoX5o7Tq+b8Jnr4144N9nifNIvk9cOr/dta0jUcDlAIx/ahwbppjQhEQR14sIeLwP/6kCgxEw+i2xKMzdQK1XeGvWgReDD7TCyT7exnxWp7UMzJVM1
d8cd06c3-6949-455c-a5a6-0f6ff6d5dcea	2b08a774-433f-4ccd-bd8f-371325e1506c	algorithm	RSA-OAEP
5e651a6b-488d-434d-b74d-e95e3dae57b5	2b08a774-433f-4ccd-bd8f-371325e1506c	keyUse	ENC
5f1a3250-cf26-4b1c-875c-d03a49832a34	2b08a774-433f-4ccd-bd8f-371325e1506c	priority	100
8fa9cb0c-5a9a-4c6c-a330-6f3f8c28ab34	636a3dcf-fed7-4198-a290-785e32b42806	privateKey	MIIEogIBAAKCAQEAyh/kJeN0ynIR1I1MK6nEx2vTMhFT/r3GaaZ9lnQ9N5tAhvChJKykp51zrjPzWBeoRkVPV63pEbrEvad4v1rDwioiODf07IVQd+lMnT/PNBi04oQwgqVu2E5ozrsWHjhbPeTGfGhQQXWIQs5d6i11dIbeklu7iCOL4n/+k0PGKNrP6qMOqq8Efg/2UUslVAB9O5QAcI6Jt8x013Vf3vzOYdBHz+bgFBn91KUZ1l/JOkpwlsdtq1XNhAPNzLz9CxQ39O9MtwIr0qr2cZiAIyprXRGx+8N26LTO2EY6jvvcsCAffb1H+cZz1eChS4WxmGpp/eFXsaNViTqgkZsTAXhhTwIDAQABAoIBAAD2bFz0DVuPPRFjhDZZdy9xuTyKXF0Lb2/pJdmFsU5GmY+D2E0QFBZxmWhvwVhe1VxvbEndm9RvOu/3ZagmTmXqNpCeMrb2+yAf9RZzEpFvgK+yJT7GeyPhsCiJN8dqLRJl1RO20iE/dGEBg7RRd8Vl9paA9gBz3Y08QpdWEBIV89jPZ6my1M9cbf9FIuxqfpCUW0RlOSFZzX1VIpiN1GfWrP8jDG3Etbp5/VBbJgvHDMYsImMcyAiybkZ1gIh0xSpuCAHLwFAvR4gVBgyAfXB6K7RBM/ONeVzMe16nCxj/hMLbXjhJV623q2UgpxLug1eyNoKBxOqyOjQs3WnL4zkCgYEA9Ydtp+cN7fQDQcvoMXE+8oAbDYHSmRDDkRRirv96hnbmzHoBIPDrWE4BL+44DL7MILINvtxp+FVQvdGNuHs/w5dR28/5HTOS8rzJee1G4GSSsYQ0k68AM4z6Nlh+GoqQetOM1EnYc1U7kOMnb4eezdGluvo5xE+J7YepIfq2TqsCgYEA0r6X5URFoFxgWOcQxZdom/zKRsxt89O/BLu5tcak8hEH9xGw4TClzxz413zIWh3RhanV7n3yF5ery1r39Hzl/UUHcCIEIy32zOke7xYv9nJMun2O5p2bES6gLcBnuekWoVltoc/SU0uu0IF7h5QYk7U1s6OW4POrxNg4RWwgp+0CgYAXq3yoyR+QpwuBVlUGHzLAUhVJkhBpbTJNVDfHQx3exKuvXrupH1Cw7KQ0qLSClgo7xK6KjdkxdZgZFJCjDk6xXm8nz77mT8iE2ipaNMO2cjuqHWKsMhzE23xrrNBLYrxW+voCpTPWuorJhvyQRfTLRsDBa8oR4NEdMwzdF7xnjQKBgH2MhCtWr/An+FIeXhSI7g433D2vXjWrSRpFyA4t6Gg5kzgytuCBPdaUWP7vXOCq8P6jPkrVh1tcxUDh0eQ6YD2xWQwJh9N5d5V9sCsZWbuFPoa/dFmZPR9QWqbHAER2Q0AeabzDdXagGOYorXII3Vdp1jNN2v3qzML5WRSqpQ3FAoGAaMyj4ewp843iiVXaj6fGR4o0/QSnK8ukYVOMlXYLLo7KWyZg1Vj/UdrMf6qUn47wcvvdV8BxnnGxlKs2hwxXEg1fH1GYg7hloGumvAZLRTJMQANsW1/vcCG8rICnAsyKc+gg408HI6sQVzT1VFGpH1ZsivSnGUyeZZL3UpPr45o=
a99978bf-78b3-4b4c-9b24-cef3455a067d	636a3dcf-fed7-4198-a290-785e32b42806	certificate	MIICpTCCAY0CBgGXIfILbzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtpbmRpdmlkdWFsczAeFw0yNTA1MzAxNjA1MDBaFw0zNTA1MzAxNjA2NDBaMBYxFDASBgNVBAMMC2luZGl2aWR1YWxzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyh/kJeN0ynIR1I1MK6nEx2vTMhFT/r3GaaZ9lnQ9N5tAhvChJKykp51zrjPzWBeoRkVPV63pEbrEvad4v1rDwioiODf07IVQd+lMnT/PNBi04oQwgqVu2E5ozrsWHjhbPeTGfGhQQXWIQs5d6i11dIbeklu7iCOL4n/+k0PGKNrP6qMOqq8Efg/2UUslVAB9O5QAcI6Jt8x013Vf3vzOYdBHz+bgFBn91KUZ1l/JOkpwlsdtq1XNhAPNzLz9CxQ39O9MtwIr0qr2cZiAIyprXRGx+8N26LTO2EY6jvvcsCAffb1H+cZz1eChS4WxmGpp/eFXsaNViTqgkZsTAXhhTwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCaPlBOIF94usoVcBMjsOzRUk4NfcpiNK46QASPEpXxkH38uirJk2LiCdos9jtY0UlDZ3/pndTXWtjH1UFeFUZPWhra+xd5/kcBYr8dBTremkZGe9RGs5j5Q3ecX1hTglR9ATDpFgk0tJVEyZ/62UzVxWpgirxIIvhvj8SbEg8VSPw4qe1A3yIQDWaonSETKraNhlNkbQWyCDgoeQg11zr6LbCq7gc5nCHS98WPh07+mjJgHNARXTq4ZIHTMiAbb8NJvkzbsjGyW2bKPwM8d1lnOYqBZ1mE1yQO1AjrWyRLyjgEEulYpsKwj0QEGKyWmzKY5mbAF5e4/+SbsmXMvDic
65fdb952-6fbe-429a-b391-d2f5b986b0e0	636a3dcf-fed7-4198-a290-785e32b42806	keyUse	SIG
c8a096f3-ae80-4c28-988f-ce92245d38ba	636a3dcf-fed7-4198-a290-785e32b42806	priority	100
beac8fa7-53e8-4ced-b71b-56671a8b5c51	2396d2df-1808-4ab2-b86a-af0b66f6c9ec	priority	100
55b6b19e-781b-488c-8901-c7be5c9e3398	2396d2df-1808-4ab2-b86a-af0b66f6c9ec	keyUse	ENC
89dd2f8e-4555-4715-96e6-8c7ff0b82abf	2396d2df-1808-4ab2-b86a-af0b66f6c9ec	certificate	MIICpTCCAY0CBgGXIfILpzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtpbmRpdmlkdWFsczAeFw0yNTA1MzAxNjA1MDBaFw0zNTA1MzAxNjA2NDBaMBYxFDASBgNVBAMMC2luZGl2aWR1YWxzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtV7ZGaLyWEOT9EFkGO43g2pVBqDBN6aH49yXYkUpv24TcCr8jx6+ZKuABavyL00BUl7L5GWene54gx6oJLGA99HyPisFvv8obgJRhmhIC/RTrVLVaW6XuSaarCN//+yV2Qv+bUnCnEJj86cGKdRR1zYl0tZxykPjZw+mq0Q3Tsfy2ZRDNilyza6xIdMkLRv2eTNFzLeVt4s34W1rwEgNfS/EuJdrhRud/dQ6dc9q4NjmTF0Z4lilVhDd/N27EA9n5j7Dq3mja9/OyijdBUPgNhcb3jPTJVIfTnLjNT3uhDBTmPutAVghNNZyiksG+6vidZ5ILRBeMQlZ/2NLAQqhJwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCO3YiUCqyzHBDTk5Hakl0/uHovIJnRRNlnml0LUDYSHS5QBs9N/bQ10ODqxz2uusIhxZcp686p0H0songGrvX+Z1InBjd/QesMnNByXR7QyXmLEoqQVGg+AKTKrCWIGbYlHjVGJOqLm73sOli2BIwnpK9wA7mZFtOPxDHnruvdf7c9DiQdlCh5PN110R9hBxBmC2V6Mbtf5sHgBKpN5MrkHuOPiIPDKV1jPhKPc2gqgtVnpw0IbwE6fbsc016ti3/gpThTRSnPvY0gbvurDusOcpDTs5eQjdilIuwo2D1J/flDzW6F63sdG8m45DGfzAjRbEud/8xTGll8UorkDiuL
ae3e6ca5-76f8-4bbc-b218-2465e5e13400	2396d2df-1808-4ab2-b86a-af0b66f6c9ec	algorithm	RSA-OAEP
61c1d0d1-a196-4066-b72d-6c4d135135df	2396d2df-1808-4ab2-b86a-af0b66f6c9ec	privateKey	MIIEowIBAAKCAQEAtV7ZGaLyWEOT9EFkGO43g2pVBqDBN6aH49yXYkUpv24TcCr8jx6+ZKuABavyL00BUl7L5GWene54gx6oJLGA99HyPisFvv8obgJRhmhIC/RTrVLVaW6XuSaarCN//+yV2Qv+bUnCnEJj86cGKdRR1zYl0tZxykPjZw+mq0Q3Tsfy2ZRDNilyza6xIdMkLRv2eTNFzLeVt4s34W1rwEgNfS/EuJdrhRud/dQ6dc9q4NjmTF0Z4lilVhDd/N27EA9n5j7Dq3mja9/OyijdBUPgNhcb3jPTJVIfTnLjNT3uhDBTmPutAVghNNZyiksG+6vidZ5ILRBeMQlZ/2NLAQqhJwIDAQABAoIBAA5mv3QELBxrEpqgqJs8KxycZa+hixtpSz1XcjkjhxrurszHdQduPa2jr9uDbuG89RUTzDp7VoVxfpCMGiDTwWBW2NaBNwhr8qC4Pr3z633w2Btun4iAIhGvFDVamkV5hTUso8wMwSRZjIiNI3Wl03EfGRDCkLAqr39VpE/Rb6zUcVEkDyLZ4mrsqoZUdCVebfMZuklx7CEvEkf/LcJFTJh6TBIDKeqEc0W+evcx1WSZuSjQh7M/ZDsAv8XU9VQ7lZISIyAdz5Fmt5p4733r6gUFtGNFaZKEvEufQKsJy2E1GgABIg9sbjjPEQQsb1EZoIlSUhBz0hQKslz3JsQYYxUCgYEA+91Mujs3UA9Ho9PQ1TPE83JFu7ikCcrDRE0nEFauszHsHT6pPO37IdM6bbC3k2tusMWor1/IB3GMJywm72f+04Kud820DqhdKmzVjc10TLDEIAORQYnXqML1saSSYvsJLlLlDYsVzlKmEgUza/0Xrkd9IWkChY9flT3sFqJom1UCgYEAuFk69/nFuXXk2EXzTBJxGAYAOPCjR/ME1NZk6zwwjObKLrJenIGtLN0OzHdTlYREEhAzx6eDf9LXmfu7QZD6/BdsyN+ac/tGUB4qfOslVVeSB+63WltrkPgmLcmU758zf+a34RndMoKOnAiPCKW0H9Ukx/JHKhzQ9wIU99kpIosCgYBwVGG9CV4BAd+UrIqOG/myDfwV3iKjD2CJXNOYUOC3oQNKg8DdINKJYnjDpTYqtJZ4lp9GIDTJRRYZ/nIbAkm/sZ/4ZLDyfJqYqlOQW9qLvaarFIw7K6wYY2NK6Dg1lvqgQ25O3QJLs8bHcLRfbFCcdNvVA82RHcGmgSiDa8m1xQKBgDgWzh5M3KAFAs/a2J+4rLhGeyLX9JYblsi7QpFgCtWUEsgKdUbhHbOcvrfvRnsjdyKX02lXymbF29t6AAt+9R5mci7b+b54IXiW9Q507TL+JexL8XWIgz3kgplD0BDoO18a76+JkwefOYy3/ez/ncJhs4Myb/ycL+g3tfGDHUTpAoGBAI9aW3pV0xhuHaZAfCm+sMqc5u+mcmqXal7TDDMO1S4f4ULER4SlwfWN5YNKd+w97o+P9K8/gYRyJZRxE47CCL6xi20loAUPraESSB3LF4ZVCD6ItIfvUcs9nYCmxQA35Uq3iQOT0VrKTOpsJrIeb3MGzNwSLRQOWwxknXWb8L7v
c382c953-7222-4c85-a49d-35b44a2d881c	6a2dd80c-74e3-4092-a917-b80550a80c64	kid	b96dc97d-b355-4cd2-82ac-5aaef2d3bf7f
740f2ae2-9b4f-430c-bb35-edf7b247742b	6a2dd80c-74e3-4092-a917-b80550a80c64	priority	100
57ca98ae-4c49-40a7-9e5a-e3c6dd7f94b7	6a2dd80c-74e3-4092-a917-b80550a80c64	secret	5SKg3XfapXryXt-KUZ5E2mxstlWnAFU8IoXFrGPkXn7L7S3Kdw9q8j824YExyFzM7gy8D0qQh-O2gKHC0E62UbV6kHUAraKAuW6SqjHBicymDai-g2iApIN-TAl7ZvFF19hShvCUxrae_v_lbE8Kw4_9j6Z9C8_ierkAH39io04
f52664f3-c0f8-4767-92f6-ea217eb69482	6a2dd80c-74e3-4092-a917-b80550a80c64	algorithm	HS512
15a75a6f-4629-4bf8-90da-324a9fa769a5	ae3ff935-1240-4af6-85e8-49ac3a5fc4da	kid	abdff61b-bb54-4bc5-bd0f-ff8f1c4985ee
b6daa0f1-d567-431d-ac06-26365c5e2611	ae3ff935-1240-4af6-85e8-49ac3a5fc4da	secret	cVFvo8prwLToACLkJCLrcA
fe0a77e7-327a-4f10-bf43-299b9c98ebc5	ae3ff935-1240-4af6-85e8-49ac3a5fc4da	priority	100
1730ef39-8297-4699-b62b-043eaa35e920	7c585e63-053b-4738-a99a-382cceb17244	client-uris-must-match	true
75e794d5-b603-4c8e-8cdc-a03e9ecc0dbb	7c585e63-053b-4738-a99a-382cceb17244	host-sending-registration-request-must-match	true
e6037410-307f-4001-a20b-2874bd8e11dd	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c5eb8fea-7454-46aa-90f3-c18765d7c3cc	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	saml-user-property-mapper
500d62c9-92c7-47ef-98b8-d624513ab71c	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
909dc73e-8cd7-4bae-ba15-c511033459d3	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	saml-user-attribute-mapper
0dba7ed1-1e79-4f3a-b523-d09d0856f619	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	oidc-address-mapper
4a669723-e1d2-4bd7-9b38-dc008a375302	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	saml-role-list-mapper
d664b411-3885-4b77-b871-807a7f91eb61	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
dee1fa12-2d23-4c43-9c51-ff599cc090ac	6d5b353a-a97a-4cc9-9ab0-d305796a55b6	allowed-protocol-mapper-types	oidc-full-name-mapper
ebaf81e8-c460-414b-aaa2-e5306a821768	a4f39e6c-c292-481c-9340-09cffe793429	allow-default-scopes	true
7e383123-c98a-4df7-8e16-dc0208b3c2a6	e762e675-dc3c-4f4c-880c-15fd067bf945	max-clients	200
4269a699-a08e-418f-837d-053bd29da39c	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3cb7f8af-dbe3-441b-84cd-1ba6e56f6c3b	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	saml-role-list-mapper
5e746b1c-63be-4d75-9709-c0763ace1c91	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	saml-user-attribute-mapper
85d13853-52b7-4d7e-ad0d-d04a04efe009	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9e480329-4c99-492f-b626-b7fb9c6980fc	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	oidc-full-name-mapper
7973f051-7f4a-4b28-92fa-55e032eb90d6	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fafc98c7-6c11-4886-a2a7-97356a436aae	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	oidc-address-mapper
16adf99f-972f-4b95-868f-7c187f4fdf9a	71a32f56-244d-4428-ab8d-c811349b637e	allowed-protocol-mapper-types	saml-user-property-mapper
2da5e8de-b829-4bdc-9f20-e201e785941c	24f75c13-c00d-423c-bae6-5bf8e1a5623c	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
2cd307ed-2746-493a-9540-377bf9a4811f	069ef783-a4c7-4584-8c71-982001f65846
2cd307ed-2746-493a-9540-377bf9a4811f	ec706eda-43c7-4b56-a64a-7be3bd828b02
2cd307ed-2746-493a-9540-377bf9a4811f	c064479d-0d7a-49de-8c10-3005f51c0c0a
2cd307ed-2746-493a-9540-377bf9a4811f	1b5a56a9-61e9-474b-938e-15d67c1dee91
2cd307ed-2746-493a-9540-377bf9a4811f	d980ede5-8978-45d0-a346-baaa633b6ae4
2cd307ed-2746-493a-9540-377bf9a4811f	be65386f-54ac-4da8-97ad-b008dd92ec57
2cd307ed-2746-493a-9540-377bf9a4811f	c2d5211c-c0bf-49d7-86b1-d5ca58a829df
2cd307ed-2746-493a-9540-377bf9a4811f	71ac5694-c5b4-401d-9310-22b73abd366f
2cd307ed-2746-493a-9540-377bf9a4811f	bfa41584-3b5a-4114-9d03-2f475a9f4a6f
2cd307ed-2746-493a-9540-377bf9a4811f	a0dcfe56-8f8d-4c1c-a6e3-3eb73d81bffd
2cd307ed-2746-493a-9540-377bf9a4811f	7b10c309-800a-4df8-b175-1325cba6e3e7
2cd307ed-2746-493a-9540-377bf9a4811f	7e9c99b1-c3d5-4220-ae04-ac06067aba55
2cd307ed-2746-493a-9540-377bf9a4811f	3b9d6f32-d039-48a2-9158-07cafc1043c2
2cd307ed-2746-493a-9540-377bf9a4811f	73063792-ee83-4fee-b973-479422ba1559
2cd307ed-2746-493a-9540-377bf9a4811f	094bc360-fa28-4aa0-8a86-12117bb25f1d
2cd307ed-2746-493a-9540-377bf9a4811f	2e5ac6b6-a819-4f73-b8b6-f35c43d34719
2cd307ed-2746-493a-9540-377bf9a4811f	19de6912-a5e1-4e34-884c-a393c670d9fc
2cd307ed-2746-493a-9540-377bf9a4811f	8ceacfe3-30fa-4eae-bede-cc815c93d957
1b5a56a9-61e9-474b-938e-15d67c1dee91	8ceacfe3-30fa-4eae-bede-cc815c93d957
1b5a56a9-61e9-474b-938e-15d67c1dee91	094bc360-fa28-4aa0-8a86-12117bb25f1d
9a1e973a-a791-42b1-9b1c-98dbee5b61c1	29fdcdfd-ccd3-48c0-a01d-4c58af783a18
d980ede5-8978-45d0-a346-baaa633b6ae4	2e5ac6b6-a819-4f73-b8b6-f35c43d34719
9a1e973a-a791-42b1-9b1c-98dbee5b61c1	a3abd72f-91da-4182-92f5-ce7c61d84a8f
a3abd72f-91da-4182-92f5-ce7c61d84a8f	1b6cb5a4-ded3-43cf-9d4d-2f5471cf4e80
5caf5cc9-cf75-40fc-8b5c-3bde68976bda	e3bc2db4-375e-453f-a111-86dbd06b05b9
2cd307ed-2746-493a-9540-377bf9a4811f	32be2179-653c-4ae3-b90b-3a259699a8d1
9a1e973a-a791-42b1-9b1c-98dbee5b61c1	2ad0e73e-3409-4ed3-9038-14600a507f2e
9a1e973a-a791-42b1-9b1c-98dbee5b61c1	358bee8a-1b4c-469d-aadc-cd402c523603
2cd307ed-2746-493a-9540-377bf9a4811f	7be72eb3-9a31-49c1-9045-92e6f94a05fa
2cd307ed-2746-493a-9540-377bf9a4811f	08826d56-8e78-4a78-b958-5148f300770a
2cd307ed-2746-493a-9540-377bf9a4811f	239a0a31-2f47-4c9e-8380-e5bdea543025
2cd307ed-2746-493a-9540-377bf9a4811f	2c50fbbf-a5b2-45d2-a8d7-65ec8198a2fb
2cd307ed-2746-493a-9540-377bf9a4811f	83b5e6c0-c1bb-4a2e-a1f8-b8dfbea8af71
2cd307ed-2746-493a-9540-377bf9a4811f	c2e4d41e-f8e7-4028-92a9-2f22edbc236c
2cd307ed-2746-493a-9540-377bf9a4811f	5dd269b2-5d26-4763-9cc1-4fe314db5c5f
2cd307ed-2746-493a-9540-377bf9a4811f	eec3c446-8238-4a5a-82b2-98aa3130191f
2cd307ed-2746-493a-9540-377bf9a4811f	b17673fe-8d75-4c1b-89db-d4be606f5963
2cd307ed-2746-493a-9540-377bf9a4811f	49caabae-f4cf-4a02-8014-2642136931c4
2cd307ed-2746-493a-9540-377bf9a4811f	3edbbf0d-95b2-4c97-8da4-1c2bba12a062
2cd307ed-2746-493a-9540-377bf9a4811f	9b6cb14b-940a-4540-adee-11f1035e3bc2
2cd307ed-2746-493a-9540-377bf9a4811f	dae72159-2f11-4e36-99c1-f9244f2d377a
2cd307ed-2746-493a-9540-377bf9a4811f	a3dcde62-e5c6-4667-89b0-533e8782f809
2cd307ed-2746-493a-9540-377bf9a4811f	d1ffd7df-6201-4d18-9308-497d4135e762
2cd307ed-2746-493a-9540-377bf9a4811f	c89f56ec-53bd-4dda-8dea-5216c91b4638
2cd307ed-2746-493a-9540-377bf9a4811f	fc86ed33-0eac-4b70-b462-5c22c910d57e
239a0a31-2f47-4c9e-8380-e5bdea543025	a3dcde62-e5c6-4667-89b0-533e8782f809
239a0a31-2f47-4c9e-8380-e5bdea543025	fc86ed33-0eac-4b70-b462-5c22c910d57e
2c50fbbf-a5b2-45d2-a8d7-65ec8198a2fb	d1ffd7df-6201-4d18-9308-497d4135e762
09ba939f-0588-4e81-b25b-91041404403d	30dd7ff3-a66e-4e9d-b4eb-19ef27c08307
09ba939f-0588-4e81-b25b-91041404403d	d0c1f784-ef6d-4e41-a4f7-db12a96659da
09ba939f-0588-4e81-b25b-91041404403d	199a9a3a-ba70-45b3-a069-e4f51d243bb3
09ba939f-0588-4e81-b25b-91041404403d	0184e47e-e49c-4f6b-8515-bf9f6da42233
09ba939f-0588-4e81-b25b-91041404403d	304f5952-2da0-4c56-b7a0-9dd1dac7f97a
09ba939f-0588-4e81-b25b-91041404403d	117908f1-727b-44b1-921c-fb09271638ca
09ba939f-0588-4e81-b25b-91041404403d	3eab1c59-2cf3-4a8e-9bc2-540766534e90
09ba939f-0588-4e81-b25b-91041404403d	1eecb9e6-12f6-4452-8a57-8cc3b28254a0
09ba939f-0588-4e81-b25b-91041404403d	efd9a18b-1cae-4c97-8088-317e034b71a2
09ba939f-0588-4e81-b25b-91041404403d	9a39c0ae-bf59-4db6-9f93-3a66933785cd
09ba939f-0588-4e81-b25b-91041404403d	f025709c-694f-4e7e-8106-d78199870295
09ba939f-0588-4e81-b25b-91041404403d	e679e30f-c68d-40be-94eb-f84ef84dd329
09ba939f-0588-4e81-b25b-91041404403d	78321e44-3620-4aaa-9bc0-895b6fd4fa2a
09ba939f-0588-4e81-b25b-91041404403d	ffc5b0f5-e238-403e-89dd-b60a73836430
09ba939f-0588-4e81-b25b-91041404403d	e6827b36-abba-4bbc-ac39-3ec6c6224485
09ba939f-0588-4e81-b25b-91041404403d	a599a73e-0c03-4625-bc3d-aa419d89328e
09ba939f-0588-4e81-b25b-91041404403d	340b8ded-08fd-49c9-b784-9972f90a8dc2
0184e47e-e49c-4f6b-8515-bf9f6da42233	e6827b36-abba-4bbc-ac39-3ec6c6224485
199a9a3a-ba70-45b3-a069-e4f51d243bb3	ffc5b0f5-e238-403e-89dd-b60a73836430
199a9a3a-ba70-45b3-a069-e4f51d243bb3	340b8ded-08fd-49c9-b784-9972f90a8dc2
28ab4178-1456-400b-b111-ac217c87c5b1	19143805-28ac-4c10-8c1d-61a89fea4172
28ab4178-1456-400b-b111-ac217c87c5b1	7c6e8fbc-b10e-4a7e-a200-09ccdaaf9089
7c6e8fbc-b10e-4a7e-a200-09ccdaaf9089	ae36a21b-7846-48e7-9694-b5fd96b535c3
03240e36-2e6f-4729-a762-86bc37a9496a	920c34b2-b6c5-4f1f-84c4-29b9a97b711a
2cd307ed-2746-493a-9540-377bf9a4811f	6576dfd3-713c-447f-8da5-b390e9059533
09ba939f-0588-4e81-b25b-91041404403d	fa62da54-9abc-4f78-b9e0-9de045e181ed
28ab4178-1456-400b-b111-ac217c87c5b1	74c0f0f0-d16d-49e5-8990-77615a7edc05
28ab4178-1456-400b-b111-ac217c87c5b1	106b59ed-836d-4269-ad2b-02466dd308ce
a40965a6-39a2-4896-8d7f-27e7ea98f76a	5814513d-d20d-4b8a-91c5-ade267dd17f9
a40965a6-39a2-4896-8d7f-27e7ea98f76a	19143805-28ac-4c10-8c1d-61a89fea4172
a40965a6-39a2-4896-8d7f-27e7ea98f76a	920c34b2-b6c5-4f1f-84c4-29b9a97b711a
a40965a6-39a2-4896-8d7f-27e7ea98f76a	fe515c56-c3f2-4ae8-9394-99c3cc05dc20
a40965a6-39a2-4896-8d7f-27e7ea98f76a	03240e36-2e6f-4729-a762-86bc37a9496a
a40965a6-39a2-4896-8d7f-27e7ea98f76a	952f1943-8899-4fd5-8c70-a2e68ed2325c
a40965a6-39a2-4896-8d7f-27e7ea98f76a	7c6e8fbc-b10e-4a7e-a200-09ccdaaf9089
a40965a6-39a2-4896-8d7f-27e7ea98f76a	ae36a21b-7846-48e7-9694-b5fd96b535c3
a40965a6-39a2-4896-8d7f-27e7ea98f76a	73306c9b-1f03-4864-8195-e21a54a6a732
a40965a6-39a2-4896-8d7f-27e7ea98f76a	cf704fae-bb60-479b-80f4-782522c39dee
a40965a6-39a2-4896-8d7f-27e7ea98f76a	ffc5b0f5-e238-403e-89dd-b60a73836430
a40965a6-39a2-4896-8d7f-27e7ea98f76a	efd9a18b-1cae-4c97-8088-317e034b71a2
a40965a6-39a2-4896-8d7f-27e7ea98f76a	199a9a3a-ba70-45b3-a069-e4f51d243bb3
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
3b03c480-10c9-42a1-94fc-dc273a1ef452	\N	password	15ba18d0-6425-458d-b770-0d79bf84fce8	1748453661302	\N	{"value":"5PlwWzgZOW4yTtZAbBm7zkRwy2zZD7Cf2Wi5yia8Ja8=","salt":"M4qBfADZpxeU6hKr9BTSJQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
b379ee13-c76d-4d29-a75e-38a7d5b6b00e	\N	password	17cf267f-9cda-475b-ab61-a3217bcc08fa	1748623777849	My password	{"value":"fpjzlu9qwvvYX7rAFOn7gR84+yG6M+8y+NV7OGOrg2E=","salt":"60FV+jbIG53/5zoWm66iOQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
b91aee29-3820-48a6-b84a-66b75681822a	\N	password	9a659f09-1ab9-4573-a644-0d5956e7e229	1748680830103	My password	{"value":"hxtOf8WTKcSnaMPtgkrlgDQjy4Ao6BNukwuwCcdsnNo=","salt":"CTF1MczKhYrGrekLc4FO6w==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	5
0f113507-4bca-4b72-9322-fc42d75a4249	\N	password	f3ddab43-ceb7-4e1e-b387-1223601fd8fe	1748894711238	\N	{"value":"c2VItiOdkJCtQU86hgaI54ln/CrBD6lChfz7bFu5vnE=","salt":"8xFZUEJ6pJPtIUvvSxJP6w==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
a77bbb14-751b-4e4e-8f3e-8601f08049ae	\N	password	fd74e914-ff19-44b7-8256-c437d2dfdac8	1748897908107	My password	{"value":"RGQdHvU6IUg1arN5uZ1O4aIpnkX221aIAlH+hwpQITE=","salt":"IF4mDpjYfS/F/mWl1Zv4PA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	2
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-05-28 17:34:14.77869	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8453654431
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-05-28 17:34:14.788441	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8453654431
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-05-28 17:34:14.820901	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	8453654431
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-05-28 17:34:14.824148	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8453654431
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-05-28 17:34:14.891971	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8453654431
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-05-28 17:34:14.896185	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8453654431
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-05-28 17:34:14.956571	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8453654431
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-05-28 17:34:14.960825	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8453654431
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-05-28 17:34:14.96604	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	8453654431
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-05-28 17:34:15.030437	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	8453654431
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-05-28 17:34:15.068589	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8453654431
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-05-28 17:34:15.071791	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8453654431
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-05-28 17:34:15.084147	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8453654431
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-05-28 17:34:15.09773	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	8453654431
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-05-28 17:34:15.099103	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-05-28 17:34:15.100884	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	8453654431
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-05-28 17:34:15.103888	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	8453654431
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-05-28 17:34:15.130292	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	8453654431
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-05-28 17:34:15.155371	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8453654431
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-05-28 17:34:15.158926	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8453654431
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-05-28 17:34:15.16154	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8453654431
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-05-28 17:34:15.163655	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8453654431
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-05-28 17:34:15.222	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	8453654431
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-05-28 17:34:15.225306	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8453654431
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-05-28 17:34:15.226507	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8453654431
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-05-28 17:34:15.496935	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	8453654431
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-05-28 17:34:15.541568	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	8453654431
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-05-28 17:34:15.544707	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8453654431
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-05-28 17:34:15.586994	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	8453654431
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-05-28 17:34:15.595555	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	8453654431
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-05-28 17:34:15.60704	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	8453654431
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-05-28 17:34:15.610532	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	8453654431
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-05-28 17:34:15.613942	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-05-28 17:34:15.615529	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8453654431
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-05-28 17:34:15.632836	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8453654431
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-05-28 17:34:15.636346	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	8453654431
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-05-28 17:34:15.640303	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8453654431
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-05-28 17:34:15.642852	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	8453654431
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-05-28 17:34:15.645095	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	8453654431
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-05-28 17:34:15.646139	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8453654431
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-05-28 17:34:15.64756	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8453654431
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-05-28 17:34:15.65056	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	8453654431
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-05-28 17:34:16.630418	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	8453654431
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-05-28 17:34:16.633824	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	8453654431
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-05-28 17:34:16.637302	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8453654431
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-05-28 17:34:16.640039	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	8453654431
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-05-28 17:34:16.641118	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8453654431
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-05-28 17:34:16.716524	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	8453654431
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-05-28 17:34:16.719319	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	8453654431
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-05-28 17:34:16.744736	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	8453654431
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-05-28 17:34:16.958097	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	8453654431
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-05-28 17:34:16.960498	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-05-28 17:34:16.962228	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	8453654431
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-05-28 17:34:16.963821	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	8453654431
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-05-28 17:34:16.968036	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	8453654431
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-05-28 17:34:16.970867	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	8453654431
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-05-28 17:34:17.00108	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	8453654431
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-05-28 17:34:17.235965	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	8453654431
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-05-28 17:34:17.251101	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	8453654431
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-05-28 17:34:17.254666	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8453654431
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-05-28 17:34:17.259533	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	8453654431
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-05-28 17:34:17.263282	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	8453654431
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-05-28 17:34:17.265758	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8453654431
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-05-28 17:34:17.267676	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8453654431
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-05-28 17:34:17.269497	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	8453654431
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-05-28 17:34:17.296242	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	8453654431
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-05-28 17:34:17.318458	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	8453654431
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-05-28 17:34:17.321292	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	8453654431
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-05-28 17:34:17.345804	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	8453654431
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-05-28 17:34:17.34913	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	8453654431
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-05-28 17:34:17.35144	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8453654431
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-05-28 17:34:17.355609	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8453654431
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-05-28 17:34:17.359652	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8453654431
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-05-28 17:34:17.360934	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8453654431
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-05-28 17:34:17.371597	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	8453654431
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-05-28 17:34:17.39441	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	8453654431
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-05-28 17:34:17.397019	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	8453654431
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-05-28 17:34:17.398014	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	8453654431
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-05-28 17:34:17.408453	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	8453654431
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-05-28 17:34:17.40966	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	8453654431
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-05-28 17:34:17.431735	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	8453654431
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-05-28 17:34:17.432827	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8453654431
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-05-28 17:34:17.435662	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8453654431
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-05-28 17:34:17.436635	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8453654431
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-05-28 17:34:17.458012	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8453654431
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-05-28 17:34:17.460813	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	8453654431
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-05-28 17:34:17.464916	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	8453654431
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-05-28 17:34:17.470373	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	8453654431
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.473941	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	8453654431
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.47746	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	8453654431
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.498787	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.503645	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	8453654431
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.504725	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8453654431
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.510457	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8453654431
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.511998	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	8453654431
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-05-28 17:34:17.516186	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	8453654431
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-05-28 17:34:17.590266	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-05-28 17:34:17.592587	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-05-28 17:34:17.601728	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-05-28 17:34:17.626435	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-05-28 17:34:17.627897	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-05-28 17:34:17.658064	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	8453654431
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-05-28 17:34:17.661864	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	8453654431
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-05-28 17:34:17.667609	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	8453654431
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-05-28 17:34:17.696919	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	8453654431
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-05-28 17:34:17.721708	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8453654431
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-05-28 17:34:17.75033	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	8453654431
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-05-28 17:34:17.753229	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	8453654431
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-05-28 17:34:17.778358	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8453654431
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-05-28 17:34:17.779927	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8453654431
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-05-28 17:34:17.78399	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-05-28 17:34:17.787523	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	8453654431
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-05-28 17:34:17.807905	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8453654431
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-05-28 17:34:17.810194	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	8453654431
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-05-28 17:34:17.813926	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	8453654431
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-05-28 17:34:17.815288	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	8453654431
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-05-28 17:34:17.819498	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	8453654431
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-05-28 17:34:17.822041	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8453654431
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-05-28 17:34:17.913099	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	8453654431
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-05-28 17:34:17.915598	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	8453654431
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-05-28 17:34:17.919327	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-05-28 17:34:17.942823	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-05-28 17:34:17.945783	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	8453654431
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-05-28 17:34:17.946851	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-05-28 17:34:17.948205	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:17.952113	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:17.975067	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.113339	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.236549	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.358887	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.476266	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.477489	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.506805	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8453654431
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.51956	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8453654431
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.526771	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8453654431
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.527993	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8453654431
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-05-28 17:34:18.576392	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	8453654431
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.581931	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	8453654431
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.586968	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	8453654431
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.611064	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8453654431
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.614393	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	8453654431
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.61858	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8453654431
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.64238	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8453654431
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.688841	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	8453654431
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.809779	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8453654431
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.816787	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	8453654431
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-05-28 17:34:18.818947	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	8453654431
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-05-28 17:34:18.824777	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	8453654431
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-05-28 17:34:18.82936	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8453654431
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-05-28 17:34:18.832506	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	8453654431
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-05-28 17:34:18.840584	151	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.29.1	\N	\N	8453654431
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-05-28 17:34:18.843671	152	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.29.1	\N	\N	8453654431
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
62548a37-f59d-45a0-adc9-27061011b0f3	f47e1b3b-dba0-48d8-9f08-380fc08a7da4	f
62548a37-f59d-45a0-adc9-27061011b0f3	794c3aab-9f27-45a5-8613-7dc9b9c485b6	t
62548a37-f59d-45a0-adc9-27061011b0f3	fbeac805-46c1-4c0c-b888-14350cc3e78c	t
62548a37-f59d-45a0-adc9-27061011b0f3	f02d3e2f-a9da-4a5b-afad-99efef10d698	t
62548a37-f59d-45a0-adc9-27061011b0f3	2b45e628-6369-46df-89fa-e9042f5a457e	t
62548a37-f59d-45a0-adc9-27061011b0f3	e6ba9c8a-0523-4bc0-9538-9d6f1d163788	f
62548a37-f59d-45a0-adc9-27061011b0f3	4a102e67-0efb-4b9a-a57b-acfab803cb5d	f
62548a37-f59d-45a0-adc9-27061011b0f3	b29e5458-18da-47d8-8e20-4a171a5052a2	t
62548a37-f59d-45a0-adc9-27061011b0f3	dab13b27-f52f-41a1-8f53-ad2af26c0d3f	t
62548a37-f59d-45a0-adc9-27061011b0f3	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270	f
62548a37-f59d-45a0-adc9-27061011b0f3	087ac527-3963-40c1-b20a-84fe86b5c899	t
62548a37-f59d-45a0-adc9-27061011b0f3	889faf51-875f-472a-8930-c6613ea92830	t
62548a37-f59d-45a0-adc9-27061011b0f3	3c136d62-b309-4deb-8c5d-b3a1bbf6609b	f
82225a6e-13a1-44cf-a86f-129f1a907c0b	1e3af7a4-cfb3-4cca-99e5-c3f5f9be600e	f
82225a6e-13a1-44cf-a86f-129f1a907c0b	df87aad3-f4e1-4aef-8ebf-7fb18de4a784	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	2eefd1ab-3338-4c3d-bc54-83473ba793a8	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	b917d452-4c45-457e-873c-00dd6bede814	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	dd296046-122a-456c-89c1-4f7b700f2d45	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	99cb8783-2390-4c1e-83c4-3acaf2f88161	f
82225a6e-13a1-44cf-a86f-129f1a907c0b	30ed3d1a-3659-48b3-8346-a99f8be722ba	f
82225a6e-13a1-44cf-a86f-129f1a907c0b	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	6901958b-38f5-4c68-9cc6-d21f08f6ac94	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	9a1c25b9-bf01-4bac-8450-cd12a260707b	f
82225a6e-13a1-44cf-a86f-129f1a907c0b	9616f400-cc03-4a5f-acd2-77cac11bb83d	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	4aac8814-2819-4331-a1e4-873f044c640b	t
82225a6e-13a1-44cf-a86f-129f1a907c0b	efcc3a03-bf40-4fbe-855f-ab6c9856ad07	f
82225a6e-13a1-44cf-a86f-129f1a907c0b	065f0853-4f27-416d-8c3c-357a42864a3f	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
9a1e973a-a791-42b1-9b1c-98dbee5b61c1	62548a37-f59d-45a0-adc9-27061011b0f3	f	${role_default-roles}	default-roles-master	62548a37-f59d-45a0-adc9-27061011b0f3	\N	\N
069ef783-a4c7-4584-8c71-982001f65846	62548a37-f59d-45a0-adc9-27061011b0f3	f	${role_create-realm}	create-realm	62548a37-f59d-45a0-adc9-27061011b0f3	\N	\N
2cd307ed-2746-493a-9540-377bf9a4811f	62548a37-f59d-45a0-adc9-27061011b0f3	f	${role_admin}	admin	62548a37-f59d-45a0-adc9-27061011b0f3	\N	\N
ec706eda-43c7-4b56-a64a-7be3bd828b02	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_create-client}	create-client	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
c064479d-0d7a-49de-8c10-3005f51c0c0a	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_view-realm}	view-realm	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
1b5a56a9-61e9-474b-938e-15d67c1dee91	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_view-users}	view-users	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
d980ede5-8978-45d0-a346-baaa633b6ae4	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_view-clients}	view-clients	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
be65386f-54ac-4da8-97ad-b008dd92ec57	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_view-events}	view-events	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
c2d5211c-c0bf-49d7-86b1-d5ca58a829df	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_view-identity-providers}	view-identity-providers	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
71ac5694-c5b4-401d-9310-22b73abd366f	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_view-authorization}	view-authorization	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
bfa41584-3b5a-4114-9d03-2f475a9f4a6f	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_manage-realm}	manage-realm	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
a0dcfe56-8f8d-4c1c-a6e3-3eb73d81bffd	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_manage-users}	manage-users	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
7b10c309-800a-4df8-b175-1325cba6e3e7	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_manage-clients}	manage-clients	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
7e9c99b1-c3d5-4220-ae04-ac06067aba55	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_manage-events}	manage-events	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
3b9d6f32-d039-48a2-9158-07cafc1043c2	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_manage-identity-providers}	manage-identity-providers	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
73063792-ee83-4fee-b973-479422ba1559	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_manage-authorization}	manage-authorization	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
094bc360-fa28-4aa0-8a86-12117bb25f1d	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_query-users}	query-users	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
2e5ac6b6-a819-4f73-b8b6-f35c43d34719	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_query-clients}	query-clients	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
19de6912-a5e1-4e34-884c-a393c670d9fc	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_query-realms}	query-realms	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
8ceacfe3-30fa-4eae-bede-cc815c93d957	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_query-groups}	query-groups	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
29fdcdfd-ccd3-48c0-a01d-4c58af783a18	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_view-profile}	view-profile	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
a3abd72f-91da-4182-92f5-ce7c61d84a8f	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_manage-account}	manage-account	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
1b6cb5a4-ded3-43cf-9d4d-2f5471cf4e80	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_manage-account-links}	manage-account-links	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
c94f78d1-2e00-41b7-a04a-8376f7e6bcd2	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_view-applications}	view-applications	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
e3bc2db4-375e-453f-a111-86dbd06b05b9	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_view-consent}	view-consent	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
5caf5cc9-cf75-40fc-8b5c-3bde68976bda	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_manage-consent}	manage-consent	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
7299c2f7-e54a-4a14-bf11-363f519b7dc8	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_view-groups}	view-groups	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
f252e639-a952-4d69-b081-074d9fed89af	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	t	${role_delete-account}	delete-account	62548a37-f59d-45a0-adc9-27061011b0f3	97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	\N
7269fade-7be8-482f-9b5b-cd6d7e32bd91	d28705a5-b340-4235-818e-eab82bd5b299	t	${role_read-token}	read-token	62548a37-f59d-45a0-adc9-27061011b0f3	d28705a5-b340-4235-818e-eab82bd5b299	\N
32be2179-653c-4ae3-b90b-3a259699a8d1	ad33cbcc-60d2-4d26-9439-45956e8095fc	t	${role_impersonation}	impersonation	62548a37-f59d-45a0-adc9-27061011b0f3	ad33cbcc-60d2-4d26-9439-45956e8095fc	\N
2ad0e73e-3409-4ed3-9038-14600a507f2e	62548a37-f59d-45a0-adc9-27061011b0f3	f	${role_offline-access}	offline_access	62548a37-f59d-45a0-adc9-27061011b0f3	\N	\N
358bee8a-1b4c-469d-aadc-cd402c523603	62548a37-f59d-45a0-adc9-27061011b0f3	f	${role_uma_authorization}	uma_authorization	62548a37-f59d-45a0-adc9-27061011b0f3	\N	\N
28ab4178-1456-400b-b111-ac217c87c5b1	82225a6e-13a1-44cf-a86f-129f1a907c0b	f	${role_default-roles}	default-roles-individuals	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N	\N
7be72eb3-9a31-49c1-9045-92e6f94a05fa	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_create-client}	create-client	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
08826d56-8e78-4a78-b958-5148f300770a	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_view-realm}	view-realm	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
239a0a31-2f47-4c9e-8380-e5bdea543025	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_view-users}	view-users	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
2c50fbbf-a5b2-45d2-a8d7-65ec8198a2fb	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_view-clients}	view-clients	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
83b5e6c0-c1bb-4a2e-a1f8-b8dfbea8af71	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_view-events}	view-events	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
c2e4d41e-f8e7-4028-92a9-2f22edbc236c	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_view-identity-providers}	view-identity-providers	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
5dd269b2-5d26-4763-9cc1-4fe314db5c5f	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_view-authorization}	view-authorization	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
eec3c446-8238-4a5a-82b2-98aa3130191f	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_manage-realm}	manage-realm	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
b17673fe-8d75-4c1b-89db-d4be606f5963	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_manage-users}	manage-users	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
49caabae-f4cf-4a02-8014-2642136931c4	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_manage-clients}	manage-clients	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
3edbbf0d-95b2-4c97-8da4-1c2bba12a062	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_manage-events}	manage-events	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
9b6cb14b-940a-4540-adee-11f1035e3bc2	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_manage-identity-providers}	manage-identity-providers	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
dae72159-2f11-4e36-99c1-f9244f2d377a	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_manage-authorization}	manage-authorization	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
a3dcde62-e5c6-4667-89b0-533e8782f809	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_query-users}	query-users	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
d1ffd7df-6201-4d18-9308-497d4135e762	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_query-clients}	query-clients	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
c89f56ec-53bd-4dda-8dea-5216c91b4638	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_query-realms}	query-realms	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
fc86ed33-0eac-4b70-b462-5c22c910d57e	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_query-groups}	query-groups	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
09ba939f-0588-4e81-b25b-91041404403d	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_realm-admin}	realm-admin	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
30dd7ff3-a66e-4e9d-b4eb-19ef27c08307	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_create-client}	create-client	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
d0c1f784-ef6d-4e41-a4f7-db12a96659da	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_view-realm}	view-realm	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
199a9a3a-ba70-45b3-a069-e4f51d243bb3	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_view-users}	view-users	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
0184e47e-e49c-4f6b-8515-bf9f6da42233	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_view-clients}	view-clients	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
304f5952-2da0-4c56-b7a0-9dd1dac7f97a	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_view-events}	view-events	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
117908f1-727b-44b1-921c-fb09271638ca	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_view-identity-providers}	view-identity-providers	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
3eab1c59-2cf3-4a8e-9bc2-540766534e90	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_view-authorization}	view-authorization	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
1eecb9e6-12f6-4452-8a57-8cc3b28254a0	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_manage-realm}	manage-realm	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
efd9a18b-1cae-4c97-8088-317e034b71a2	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_manage-users}	manage-users	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
9a39c0ae-bf59-4db6-9f93-3a66933785cd	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_manage-clients}	manage-clients	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
f025709c-694f-4e7e-8106-d78199870295	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_manage-events}	manage-events	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
e679e30f-c68d-40be-94eb-f84ef84dd329	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_manage-identity-providers}	manage-identity-providers	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
78321e44-3620-4aaa-9bc0-895b6fd4fa2a	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_manage-authorization}	manage-authorization	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
ffc5b0f5-e238-403e-89dd-b60a73836430	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_query-users}	query-users	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
e6827b36-abba-4bbc-ac39-3ec6c6224485	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_query-clients}	query-clients	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
a599a73e-0c03-4625-bc3d-aa419d89328e	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_query-realms}	query-realms	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
340b8ded-08fd-49c9-b784-9972f90a8dc2	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_query-groups}	query-groups	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
19143805-28ac-4c10-8c1d-61a89fea4172	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_view-profile}	view-profile	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
7c6e8fbc-b10e-4a7e-a200-09ccdaaf9089	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_manage-account}	manage-account	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
ae36a21b-7846-48e7-9694-b5fd96b535c3	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_manage-account-links}	manage-account-links	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
73306c9b-1f03-4864-8195-e21a54a6a732	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_view-applications}	view-applications	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
920c34b2-b6c5-4f1f-84c4-29b9a97b711a	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_view-consent}	view-consent	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
03240e36-2e6f-4729-a762-86bc37a9496a	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_manage-consent}	manage-consent	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
cf704fae-bb60-479b-80f4-782522c39dee	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_view-groups}	view-groups	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
5814513d-d20d-4b8a-91c5-ade267dd17f9	96a5665e-3543-4736-9605-1cae60ce7016	t	${role_delete-account}	delete-account	82225a6e-13a1-44cf-a86f-129f1a907c0b	96a5665e-3543-4736-9605-1cae60ce7016	\N
6576dfd3-713c-447f-8da5-b390e9059533	e24cff59-2e0b-4ef6-9991-8b3e62a43178	t	${role_impersonation}	impersonation	62548a37-f59d-45a0-adc9-27061011b0f3	e24cff59-2e0b-4ef6-9991-8b3e62a43178	\N
fa62da54-9abc-4f78-b9e0-9de045e181ed	be77b0c4-7221-4f71-ad76-35d75b8c654f	t	${role_impersonation}	impersonation	82225a6e-13a1-44cf-a86f-129f1a907c0b	be77b0c4-7221-4f71-ad76-35d75b8c654f	\N
952f1943-8899-4fd5-8c70-a2e68ed2325c	f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	t	${role_read-token}	read-token	82225a6e-13a1-44cf-a86f-129f1a907c0b	f4888d86-c6e0-4b2f-afa6-5e3fa733e4a3	\N
74c0f0f0-d16d-49e5-8990-77615a7edc05	82225a6e-13a1-44cf-a86f-129f1a907c0b	f	${role_offline-access}	offline_access	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N	\N
106b59ed-836d-4269-ad2b-02466dd308ce	82225a6e-13a1-44cf-a86f-129f1a907c0b	f	${role_uma_authorization}	uma_authorization	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N	\N
a40965a6-39a2-4896-8d7f-27e7ea98f76a	82225a6e-13a1-44cf-a86f-129f1a907c0b	f		individuals.admin	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N	\N
4f3dc99c-fbdf-4fd7-ad06-0d31e1fce611	82225a6e-13a1-44cf-a86f-129f1a907c0b	f		individuals.user	82225a6e-13a1-44cf-a86f-129f1a907c0b	\N	\N
fe515c56-c3f2-4ae8-9394-99c3cc05dc20	50d26acd-9eea-4f82-865e-16a8cfc79cff	t	\N	uma_protection	82225a6e-13a1-44cf-a86f-129f1a907c0b	50d26acd-9eea-4f82-865e-16a8cfc79cff	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
m5mbj	26.2.5	1748453659
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
a82eb0e9-b708-443b-8ea2-7aa1bc504d39	d8fcc746-02b4-40c5-8868-ab2ad6036800	0	1749155093	{"authMethod":"openid-connect","redirectUri":"http://localhost:9091/realms/master/account?referrer=security-admin-console&referrer_uri=http%3A%2F%2Flocalhost%3A9091%2Fadmin%2Fmaster%2Fconsole%2F","notes":{"clientId":"d8fcc746-02b4-40c5-8868-ab2ad6036800","iss":"http://localhost:9091/realms/master","startedAt":"1749155092","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ab0d15fe-79b6-4eb9-9b8e-84dbc94e7195","response_mode":"query","scope":"openid","SSO_AUTH":"true","userSessionStartedAt":"1749155084","redirect_uri":"http://localhost:9091/realms/master/account?referrer=security-admin-console&referrer_uri=http%3A%2F%2Flocalhost%3A9091%2Fadmin%2Fmaster%2Fconsole%2F","state":"0e3e95d5-55cf-4fee-8ff5-26d1cf748819","prompt":"none","code_challenge":"8-L1R6FFNgDMxQjEsOo7R13L-FQLG4HZTWiB_l5Wi5U"}}	local	local	1
a82eb0e9-b708-443b-8ea2-7aa1bc504d39	ec343f09-000f-4118-bd65-b627552fda3d	0	1749155345	{"authMethod":"openid-connect","redirectUri":"http://localhost:9091/admin/master/console/","notes":{"clientId":"ec343f09-000f-4118-bd65-b627552fda3d","iss":"http://localhost:9091/realms/master","startedAt":"1749155084","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"e7e5f3ec-0614-4219-9132-4c21c5f9420a","response_mode":"query","scope":"openid","userSessionStartedAt":"1749155084","redirect_uri":"http://localhost:9091/admin/master/console/","state":"e835dae8-3321-4688-983c-7597ad965f90","code_challenge":"L0nTThYw4PjUVSH1NnzlzBMl896NhTfPEG5FMaej8Xk","prompt":"none","SSO_AUTH":"true"}}	local	local	5
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
a82eb0e9-b708-443b-8ea2-7aa1bc504d39	15ba18d0-6425-458d-b770-0d79bf84fce8	62548a37-f59d-45a0-adc9-27061011b0f3	1749155084	0	{"ipAddress":"172.19.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTkuMC4xIiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEzNy4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1749155084","authenticators-completed":"{\\"275051a5-41fc-45e1-9c3f-58244e87bf1d\\":1749155084,\\"e1282a1c-d1e1-41f1-8d85-78d5917df3eb\\":1749155099}"},"state":"LOGGED_IN"}	1749155345	\N	9
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
8355087a-9dd9-4cc4-b248-fadb89e47fa6	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
756b6c8b-fab4-4ec1-9de6-2b22fc628505	defaultResourceType	urn:individuals:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
5a136749-2ca2-4769-ae2b-60d34a325073	audience resolve	openid-connect	oidc-audience-resolve-mapper	d8fcc746-02b4-40c5-8868-ab2ad6036800	\N
282363ca-adef-4f38-809e-08892ab82536	locale	openid-connect	oidc-usermodel-attribute-mapper	ec343f09-000f-4118-bd65-b627552fda3d	\N
221b69a8-190c-4c8a-95c1-ac0146a2b89c	role list	saml	saml-role-list-mapper	\N	794c3aab-9f27-45a5-8613-7dc9b9c485b6
6a7adedd-f695-40e6-b8d5-71ba06ede1b0	organization	saml	saml-organization-membership-mapper	\N	fbeac805-46c1-4c0c-b888-14350cc3e78c
a04555a0-ca85-4341-b4af-1ef89946e7b9	full name	openid-connect	oidc-full-name-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
7d889c7b-a945-4a97-857e-4eb34c4e13b1	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	username	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
15b4dfbe-4a33-414a-aba2-77a78841fdb2	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
dc425504-6a79-4548-ae8f-8916b637d8ce	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
1a810b70-e05a-46b1-a511-63c5115ecadd	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
b368621b-cad1-43e6-a269-3198a4812464	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
a89efe79-dc5e-4421-a410-5248b953bd0f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
21efb04f-610c-48e2-8f44-3d265872c54e	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f02d3e2f-a9da-4a5b-afad-99efef10d698
2f62768f-f9e1-4f91-937c-1b59ac735d7f	email	openid-connect	oidc-usermodel-attribute-mapper	\N	2b45e628-6369-46df-89fa-e9042f5a457e
912f68b2-87dc-43ba-a79f-81fe4a01937a	email verified	openid-connect	oidc-usermodel-property-mapper	\N	2b45e628-6369-46df-89fa-e9042f5a457e
2787dfb0-640d-445f-a5a3-552388760eaf	address	openid-connect	oidc-address-mapper	\N	e6ba9c8a-0523-4bc0-9538-9d6f1d163788
4c2dfb69-6091-48ad-81da-e0951b3b480a	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	4a102e67-0efb-4b9a-a57b-acfab803cb5d
b2dd4955-45f1-4b22-b39a-dbf0bf082847	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	4a102e67-0efb-4b9a-a57b-acfab803cb5d
09590442-4e73-4718-872c-5bcad204719b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b29e5458-18da-47d8-8e20-4a171a5052a2
a5e99daf-d120-419a-a02a-f8d843de1ec2	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b29e5458-18da-47d8-8e20-4a171a5052a2
84a29f84-55aa-41df-9a93-95e101443a67	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b29e5458-18da-47d8-8e20-4a171a5052a2
06dc2075-5110-478b-8d25-2b36a0f18a67	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	dab13b27-f52f-41a1-8f53-ad2af26c0d3f
c3348212-2a31-46a4-aca6-c4cb371d0605	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	d0dbe712-ef45-4cb6-8acc-e5cc24fc8270
f2f9cb20-925e-4179-8173-01060374a895	acr loa level	openid-connect	oidc-acr-mapper	\N	087ac527-3963-40c1-b20a-84fe86b5c899
89fa4f21-7cde-4a0f-956d-6ba657629ca4	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	889faf51-875f-472a-8930-c6613ea92830
3b29cdbe-8d0c-4cad-8696-f55dd75f62fb	sub	openid-connect	oidc-sub-mapper	\N	889faf51-875f-472a-8930-c6613ea92830
c47e9399-66c0-425f-a5e3-e4d295a3f2a4	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	ec6b397e-a1a6-4465-bc66-ce27dce27167
67db1025-5458-4c79-ac0e-cb4f0610c4d5	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	ec6b397e-a1a6-4465-bc66-ce27dce27167
685c5989-c270-430f-9b93-99a1aaccc2cf	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	ec6b397e-a1a6-4465-bc66-ce27dce27167
25e39138-300c-464d-a0be-5648d21fcdf2	organization	openid-connect	oidc-organization-membership-mapper	\N	3c136d62-b309-4deb-8c5d-b3a1bbf6609b
0e9055c5-2603-45e4-b53c-1e00930ff550	audience resolve	openid-connect	oidc-audience-resolve-mapper	f35a3398-1aad-4f3b-94f5-da5ebefb53f1	\N
9b498705-cc65-4967-a92e-43f11e4aea1e	role list	saml	saml-role-list-mapper	\N	df87aad3-f4e1-4aef-8ebf-7fb18de4a784
acb74be8-4ce2-475e-81d9-0addae58f54b	organization	saml	saml-organization-membership-mapper	\N	2eefd1ab-3338-4c3d-bc54-83473ba793a8
66c7b01b-2e03-4b94-b8a2-6efd350c32e1	full name	openid-connect	oidc-full-name-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
3475c186-3632-4abc-ab95-9f64249d9330	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
a327638c-8126-4716-80da-993f2ab7e85f	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
09dfc949-be6c-439d-bb65-817c501bb511	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
e4222c90-5b1b-47b5-9521-c0dbac527243	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
da5f8ef2-5114-48c1-97b8-9e66db14154e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
33bf109e-8eb7-4253-9d03-f4506606d1bd	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
57afb75f-0a3b-49d1-a4aa-c138426800e6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
f045a46e-04e9-49d3-9268-f6df0f8fea5d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
1b655298-3123-49d3-8ea6-7fbbc54dd682	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
09f288ce-7334-4121-9d7f-526c7f729b7a	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b917d452-4c45-457e-873c-00dd6bede814
909eb95d-ea38-4137-b4d1-7b6cdb881342	email	openid-connect	oidc-usermodel-attribute-mapper	\N	dd296046-122a-456c-89c1-4f7b700f2d45
283fc441-43fb-4fb3-a901-72c80cc2a994	email verified	openid-connect	oidc-usermodel-property-mapper	\N	dd296046-122a-456c-89c1-4f7b700f2d45
6e826527-154f-4f7f-a7ce-d9f815e95adf	address	openid-connect	oidc-address-mapper	\N	99cb8783-2390-4c1e-83c4-3acaf2f88161
315a31aa-2182-495a-b921-b94a92d20ccd	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	30ed3d1a-3659-48b3-8346-a99f8be722ba
58985bd0-f3bb-4bbe-a857-47c6878502e5	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	30ed3d1a-3659-48b3-8346-a99f8be722ba
9c76771e-ff36-4375-9337-9d5455e75bc1	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1
22684229-d5cf-423a-9a7c-555329d5e709	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1
10b0d34b-4563-44e1-8cbc-8bf04b6fe249	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	75fcb26a-25cc-46ce-8d2f-5cc81f293ec1
99eaf32a-eafd-4134-8474-91d4cbcee105	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	6901958b-38f5-4c68-9cc6-d21f08f6ac94
8e7e5c47-640d-436b-afbb-727f9a531df6	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	9a1c25b9-bf01-4bac-8450-cd12a260707b
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9a1c25b9-bf01-4bac-8450-cd12a260707b
4eaae0ab-5d4f-4fb0-b5e0-7d0c3eae5328	acr loa level	openid-connect	oidc-acr-mapper	\N	9616f400-cc03-4a5f-acd2-77cac11bb83d
088b12d0-baa6-4b63-8e20-1176af92efa9	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	4aac8814-2819-4331-a1e4-873f044c640b
b85bb9db-6616-4126-a49d-8676e73c4a71	sub	openid-connect	oidc-sub-mapper	\N	4aac8814-2819-4331-a1e4-873f044c640b
db82b5d5-4df0-457c-bd47-199848cbd9db	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	28213ce9-eb37-40c1-b149-21114f6cc28b
d1be231f-a083-457e-b17e-591f0893d3ef	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	28213ce9-eb37-40c1-b149-21114f6cc28b
865d4c3b-3cad-4f10-af2c-ae11fb448046	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	28213ce9-eb37-40c1-b149-21114f6cc28b
3298c451-8abd-4735-87c9-58083fbf7e88	organization	openid-connect	oidc-organization-membership-mapper	\N	efcc3a03-bf40-4fbe-855f-ab6c9856ad07
4d134a7c-9680-4f79-8315-7d66e985b0cc	locale	openid-connect	oidc-usermodel-attribute-mapper	2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
282363ca-adef-4f38-809e-08892ab82536	true	introspection.token.claim
282363ca-adef-4f38-809e-08892ab82536	true	userinfo.token.claim
282363ca-adef-4f38-809e-08892ab82536	locale	user.attribute
282363ca-adef-4f38-809e-08892ab82536	true	id.token.claim
282363ca-adef-4f38-809e-08892ab82536	true	access.token.claim
282363ca-adef-4f38-809e-08892ab82536	locale	claim.name
282363ca-adef-4f38-809e-08892ab82536	String	jsonType.label
221b69a8-190c-4c8a-95c1-ac0146a2b89c	false	single
221b69a8-190c-4c8a-95c1-ac0146a2b89c	Basic	attribute.nameformat
221b69a8-190c-4c8a-95c1-ac0146a2b89c	Role	attribute.name
15b4dfbe-4a33-414a-aba2-77a78841fdb2	true	introspection.token.claim
15b4dfbe-4a33-414a-aba2-77a78841fdb2	true	userinfo.token.claim
15b4dfbe-4a33-414a-aba2-77a78841fdb2	profile	user.attribute
15b4dfbe-4a33-414a-aba2-77a78841fdb2	true	id.token.claim
15b4dfbe-4a33-414a-aba2-77a78841fdb2	true	access.token.claim
15b4dfbe-4a33-414a-aba2-77a78841fdb2	profile	claim.name
15b4dfbe-4a33-414a-aba2-77a78841fdb2	String	jsonType.label
1a810b70-e05a-46b1-a511-63c5115ecadd	true	introspection.token.claim
1a810b70-e05a-46b1-a511-63c5115ecadd	true	userinfo.token.claim
1a810b70-e05a-46b1-a511-63c5115ecadd	birthdate	user.attribute
1a810b70-e05a-46b1-a511-63c5115ecadd	true	id.token.claim
1a810b70-e05a-46b1-a511-63c5115ecadd	true	access.token.claim
1a810b70-e05a-46b1-a511-63c5115ecadd	birthdate	claim.name
1a810b70-e05a-46b1-a511-63c5115ecadd	String	jsonType.label
21efb04f-610c-48e2-8f44-3d265872c54e	true	introspection.token.claim
21efb04f-610c-48e2-8f44-3d265872c54e	true	userinfo.token.claim
21efb04f-610c-48e2-8f44-3d265872c54e	updatedAt	user.attribute
21efb04f-610c-48e2-8f44-3d265872c54e	true	id.token.claim
21efb04f-610c-48e2-8f44-3d265872c54e	true	access.token.claim
21efb04f-610c-48e2-8f44-3d265872c54e	updated_at	claim.name
21efb04f-610c-48e2-8f44-3d265872c54e	long	jsonType.label
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	true	introspection.token.claim
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	true	userinfo.token.claim
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	picture	user.attribute
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	true	id.token.claim
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	true	access.token.claim
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	picture	claim.name
374a39a5-cc2a-48e6-9bb9-3f712d0cfd9e	String	jsonType.label
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	true	introspection.token.claim
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	true	userinfo.token.claim
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	lastName	user.attribute
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	true	id.token.claim
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	true	access.token.claim
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	family_name	claim.name
3cbc17da-4e91-4f54-bfa6-bc290dbf4b87	String	jsonType.label
7d889c7b-a945-4a97-857e-4eb34c4e13b1	true	introspection.token.claim
7d889c7b-a945-4a97-857e-4eb34c4e13b1	true	userinfo.token.claim
7d889c7b-a945-4a97-857e-4eb34c4e13b1	firstName	user.attribute
7d889c7b-a945-4a97-857e-4eb34c4e13b1	true	id.token.claim
7d889c7b-a945-4a97-857e-4eb34c4e13b1	true	access.token.claim
7d889c7b-a945-4a97-857e-4eb34c4e13b1	given_name	claim.name
7d889c7b-a945-4a97-857e-4eb34c4e13b1	String	jsonType.label
a04555a0-ca85-4341-b4af-1ef89946e7b9	true	introspection.token.claim
a04555a0-ca85-4341-b4af-1ef89946e7b9	true	userinfo.token.claim
a04555a0-ca85-4341-b4af-1ef89946e7b9	true	id.token.claim
a04555a0-ca85-4341-b4af-1ef89946e7b9	true	access.token.claim
a89efe79-dc5e-4421-a410-5248b953bd0f	true	introspection.token.claim
a89efe79-dc5e-4421-a410-5248b953bd0f	true	userinfo.token.claim
a89efe79-dc5e-4421-a410-5248b953bd0f	locale	user.attribute
a89efe79-dc5e-4421-a410-5248b953bd0f	true	id.token.claim
a89efe79-dc5e-4421-a410-5248b953bd0f	true	access.token.claim
a89efe79-dc5e-4421-a410-5248b953bd0f	locale	claim.name
a89efe79-dc5e-4421-a410-5248b953bd0f	String	jsonType.label
b368621b-cad1-43e6-a269-3198a4812464	true	introspection.token.claim
b368621b-cad1-43e6-a269-3198a4812464	true	userinfo.token.claim
b368621b-cad1-43e6-a269-3198a4812464	zoneinfo	user.attribute
b368621b-cad1-43e6-a269-3198a4812464	true	id.token.claim
b368621b-cad1-43e6-a269-3198a4812464	true	access.token.claim
b368621b-cad1-43e6-a269-3198a4812464	zoneinfo	claim.name
b368621b-cad1-43e6-a269-3198a4812464	String	jsonType.label
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	true	introspection.token.claim
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	true	userinfo.token.claim
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	username	user.attribute
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	true	id.token.claim
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	true	access.token.claim
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	preferred_username	claim.name
ce7a09cb-1ffe-408f-a9c5-ce5f8c4c220a	String	jsonType.label
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	true	introspection.token.claim
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	true	userinfo.token.claim
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	website	user.attribute
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	true	id.token.claim
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	true	access.token.claim
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	website	claim.name
cf553c28-29a7-43e5-b4f6-2dcdd4a84cc8	String	jsonType.label
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	true	introspection.token.claim
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	true	userinfo.token.claim
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	nickname	user.attribute
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	true	id.token.claim
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	true	access.token.claim
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	nickname	claim.name
d5eb3d29-27fd-43aa-9eff-9fc9c75acbc6	String	jsonType.label
dc425504-6a79-4548-ae8f-8916b637d8ce	true	introspection.token.claim
dc425504-6a79-4548-ae8f-8916b637d8ce	true	userinfo.token.claim
dc425504-6a79-4548-ae8f-8916b637d8ce	gender	user.attribute
dc425504-6a79-4548-ae8f-8916b637d8ce	true	id.token.claim
dc425504-6a79-4548-ae8f-8916b637d8ce	true	access.token.claim
dc425504-6a79-4548-ae8f-8916b637d8ce	gender	claim.name
dc425504-6a79-4548-ae8f-8916b637d8ce	String	jsonType.label
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	true	introspection.token.claim
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	true	userinfo.token.claim
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	middleName	user.attribute
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	true	id.token.claim
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	true	access.token.claim
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	middle_name	claim.name
ef2a7770-ffa0-4bc8-8a64-f65c1489e851	String	jsonType.label
2f62768f-f9e1-4f91-937c-1b59ac735d7f	true	introspection.token.claim
2f62768f-f9e1-4f91-937c-1b59ac735d7f	true	userinfo.token.claim
2f62768f-f9e1-4f91-937c-1b59ac735d7f	email	user.attribute
2f62768f-f9e1-4f91-937c-1b59ac735d7f	true	id.token.claim
2f62768f-f9e1-4f91-937c-1b59ac735d7f	true	access.token.claim
2f62768f-f9e1-4f91-937c-1b59ac735d7f	email	claim.name
2f62768f-f9e1-4f91-937c-1b59ac735d7f	String	jsonType.label
912f68b2-87dc-43ba-a79f-81fe4a01937a	true	introspection.token.claim
912f68b2-87dc-43ba-a79f-81fe4a01937a	true	userinfo.token.claim
912f68b2-87dc-43ba-a79f-81fe4a01937a	emailVerified	user.attribute
912f68b2-87dc-43ba-a79f-81fe4a01937a	true	id.token.claim
912f68b2-87dc-43ba-a79f-81fe4a01937a	true	access.token.claim
912f68b2-87dc-43ba-a79f-81fe4a01937a	email_verified	claim.name
912f68b2-87dc-43ba-a79f-81fe4a01937a	boolean	jsonType.label
2787dfb0-640d-445f-a5a3-552388760eaf	formatted	user.attribute.formatted
2787dfb0-640d-445f-a5a3-552388760eaf	country	user.attribute.country
2787dfb0-640d-445f-a5a3-552388760eaf	true	introspection.token.claim
2787dfb0-640d-445f-a5a3-552388760eaf	postal_code	user.attribute.postal_code
2787dfb0-640d-445f-a5a3-552388760eaf	true	userinfo.token.claim
2787dfb0-640d-445f-a5a3-552388760eaf	street	user.attribute.street
2787dfb0-640d-445f-a5a3-552388760eaf	true	id.token.claim
2787dfb0-640d-445f-a5a3-552388760eaf	region	user.attribute.region
2787dfb0-640d-445f-a5a3-552388760eaf	true	access.token.claim
2787dfb0-640d-445f-a5a3-552388760eaf	locality	user.attribute.locality
4c2dfb69-6091-48ad-81da-e0951b3b480a	true	introspection.token.claim
4c2dfb69-6091-48ad-81da-e0951b3b480a	true	userinfo.token.claim
4c2dfb69-6091-48ad-81da-e0951b3b480a	phoneNumber	user.attribute
4c2dfb69-6091-48ad-81da-e0951b3b480a	true	id.token.claim
4c2dfb69-6091-48ad-81da-e0951b3b480a	true	access.token.claim
4c2dfb69-6091-48ad-81da-e0951b3b480a	phone_number	claim.name
4c2dfb69-6091-48ad-81da-e0951b3b480a	String	jsonType.label
b2dd4955-45f1-4b22-b39a-dbf0bf082847	true	introspection.token.claim
b2dd4955-45f1-4b22-b39a-dbf0bf082847	true	userinfo.token.claim
b2dd4955-45f1-4b22-b39a-dbf0bf082847	phoneNumberVerified	user.attribute
b2dd4955-45f1-4b22-b39a-dbf0bf082847	true	id.token.claim
b2dd4955-45f1-4b22-b39a-dbf0bf082847	true	access.token.claim
b2dd4955-45f1-4b22-b39a-dbf0bf082847	phone_number_verified	claim.name
b2dd4955-45f1-4b22-b39a-dbf0bf082847	boolean	jsonType.label
09590442-4e73-4718-872c-5bcad204719b	true	introspection.token.claim
09590442-4e73-4718-872c-5bcad204719b	true	multivalued
09590442-4e73-4718-872c-5bcad204719b	foo	user.attribute
09590442-4e73-4718-872c-5bcad204719b	true	access.token.claim
09590442-4e73-4718-872c-5bcad204719b	realm_access.roles	claim.name
09590442-4e73-4718-872c-5bcad204719b	String	jsonType.label
84a29f84-55aa-41df-9a93-95e101443a67	true	introspection.token.claim
84a29f84-55aa-41df-9a93-95e101443a67	true	access.token.claim
a5e99daf-d120-419a-a02a-f8d843de1ec2	true	introspection.token.claim
a5e99daf-d120-419a-a02a-f8d843de1ec2	true	multivalued
a5e99daf-d120-419a-a02a-f8d843de1ec2	foo	user.attribute
a5e99daf-d120-419a-a02a-f8d843de1ec2	true	access.token.claim
a5e99daf-d120-419a-a02a-f8d843de1ec2	resource_access.${client_id}.roles	claim.name
a5e99daf-d120-419a-a02a-f8d843de1ec2	String	jsonType.label
06dc2075-5110-478b-8d25-2b36a0f18a67	true	introspection.token.claim
06dc2075-5110-478b-8d25-2b36a0f18a67	true	access.token.claim
c3348212-2a31-46a4-aca6-c4cb371d0605	true	introspection.token.claim
c3348212-2a31-46a4-aca6-c4cb371d0605	true	userinfo.token.claim
c3348212-2a31-46a4-aca6-c4cb371d0605	username	user.attribute
c3348212-2a31-46a4-aca6-c4cb371d0605	true	id.token.claim
c3348212-2a31-46a4-aca6-c4cb371d0605	true	access.token.claim
c3348212-2a31-46a4-aca6-c4cb371d0605	upn	claim.name
c3348212-2a31-46a4-aca6-c4cb371d0605	String	jsonType.label
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	true	introspection.token.claim
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	true	multivalued
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	foo	user.attribute
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	true	id.token.claim
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	true	access.token.claim
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	groups	claim.name
d96d9343-ba4c-44c7-81fc-e4cd74e5a755	String	jsonType.label
f2f9cb20-925e-4179-8173-01060374a895	true	introspection.token.claim
f2f9cb20-925e-4179-8173-01060374a895	true	id.token.claim
f2f9cb20-925e-4179-8173-01060374a895	true	access.token.claim
3b29cdbe-8d0c-4cad-8696-f55dd75f62fb	true	introspection.token.claim
3b29cdbe-8d0c-4cad-8696-f55dd75f62fb	true	access.token.claim
89fa4f21-7cde-4a0f-956d-6ba657629ca4	AUTH_TIME	user.session.note
89fa4f21-7cde-4a0f-956d-6ba657629ca4	true	introspection.token.claim
89fa4f21-7cde-4a0f-956d-6ba657629ca4	true	id.token.claim
89fa4f21-7cde-4a0f-956d-6ba657629ca4	true	access.token.claim
89fa4f21-7cde-4a0f-956d-6ba657629ca4	auth_time	claim.name
89fa4f21-7cde-4a0f-956d-6ba657629ca4	long	jsonType.label
67db1025-5458-4c79-ac0e-cb4f0610c4d5	clientHost	user.session.note
67db1025-5458-4c79-ac0e-cb4f0610c4d5	true	introspection.token.claim
67db1025-5458-4c79-ac0e-cb4f0610c4d5	true	id.token.claim
67db1025-5458-4c79-ac0e-cb4f0610c4d5	true	access.token.claim
67db1025-5458-4c79-ac0e-cb4f0610c4d5	clientHost	claim.name
67db1025-5458-4c79-ac0e-cb4f0610c4d5	String	jsonType.label
685c5989-c270-430f-9b93-99a1aaccc2cf	clientAddress	user.session.note
685c5989-c270-430f-9b93-99a1aaccc2cf	true	introspection.token.claim
685c5989-c270-430f-9b93-99a1aaccc2cf	true	id.token.claim
685c5989-c270-430f-9b93-99a1aaccc2cf	true	access.token.claim
685c5989-c270-430f-9b93-99a1aaccc2cf	clientAddress	claim.name
685c5989-c270-430f-9b93-99a1aaccc2cf	String	jsonType.label
c47e9399-66c0-425f-a5e3-e4d295a3f2a4	client_id	user.session.note
c47e9399-66c0-425f-a5e3-e4d295a3f2a4	true	introspection.token.claim
c47e9399-66c0-425f-a5e3-e4d295a3f2a4	true	id.token.claim
c47e9399-66c0-425f-a5e3-e4d295a3f2a4	true	access.token.claim
c47e9399-66c0-425f-a5e3-e4d295a3f2a4	client_id	claim.name
c47e9399-66c0-425f-a5e3-e4d295a3f2a4	String	jsonType.label
25e39138-300c-464d-a0be-5648d21fcdf2	true	introspection.token.claim
25e39138-300c-464d-a0be-5648d21fcdf2	true	multivalued
25e39138-300c-464d-a0be-5648d21fcdf2	true	id.token.claim
25e39138-300c-464d-a0be-5648d21fcdf2	true	access.token.claim
25e39138-300c-464d-a0be-5648d21fcdf2	organization	claim.name
25e39138-300c-464d-a0be-5648d21fcdf2	String	jsonType.label
9b498705-cc65-4967-a92e-43f11e4aea1e	false	single
9b498705-cc65-4967-a92e-43f11e4aea1e	Basic	attribute.nameformat
9b498705-cc65-4967-a92e-43f11e4aea1e	Role	attribute.name
09dfc949-be6c-439d-bb65-817c501bb511	true	introspection.token.claim
09dfc949-be6c-439d-bb65-817c501bb511	true	userinfo.token.claim
09dfc949-be6c-439d-bb65-817c501bb511	nickname	user.attribute
09dfc949-be6c-439d-bb65-817c501bb511	true	id.token.claim
09dfc949-be6c-439d-bb65-817c501bb511	true	access.token.claim
09dfc949-be6c-439d-bb65-817c501bb511	nickname	claim.name
09dfc949-be6c-439d-bb65-817c501bb511	String	jsonType.label
09f288ce-7334-4121-9d7f-526c7f729b7a	true	introspection.token.claim
09f288ce-7334-4121-9d7f-526c7f729b7a	true	userinfo.token.claim
09f288ce-7334-4121-9d7f-526c7f729b7a	updatedAt	user.attribute
09f288ce-7334-4121-9d7f-526c7f729b7a	true	id.token.claim
09f288ce-7334-4121-9d7f-526c7f729b7a	true	access.token.claim
09f288ce-7334-4121-9d7f-526c7f729b7a	updated_at	claim.name
09f288ce-7334-4121-9d7f-526c7f729b7a	long	jsonType.label
1b655298-3123-49d3-8ea6-7fbbc54dd682	true	introspection.token.claim
1b655298-3123-49d3-8ea6-7fbbc54dd682	true	userinfo.token.claim
1b655298-3123-49d3-8ea6-7fbbc54dd682	locale	user.attribute
1b655298-3123-49d3-8ea6-7fbbc54dd682	true	id.token.claim
1b655298-3123-49d3-8ea6-7fbbc54dd682	true	access.token.claim
1b655298-3123-49d3-8ea6-7fbbc54dd682	locale	claim.name
1b655298-3123-49d3-8ea6-7fbbc54dd682	String	jsonType.label
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	true	introspection.token.claim
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	true	userinfo.token.claim
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	gender	user.attribute
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	true	id.token.claim
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	true	access.token.claim
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	gender	claim.name
1e866e97-3d4d-4b80-893f-58ea4ccd2f28	String	jsonType.label
33bf109e-8eb7-4253-9d03-f4506606d1bd	true	introspection.token.claim
33bf109e-8eb7-4253-9d03-f4506606d1bd	true	userinfo.token.claim
33bf109e-8eb7-4253-9d03-f4506606d1bd	picture	user.attribute
33bf109e-8eb7-4253-9d03-f4506606d1bd	true	id.token.claim
33bf109e-8eb7-4253-9d03-f4506606d1bd	true	access.token.claim
33bf109e-8eb7-4253-9d03-f4506606d1bd	picture	claim.name
33bf109e-8eb7-4253-9d03-f4506606d1bd	String	jsonType.label
3475c186-3632-4abc-ab95-9f64249d9330	true	introspection.token.claim
3475c186-3632-4abc-ab95-9f64249d9330	true	userinfo.token.claim
3475c186-3632-4abc-ab95-9f64249d9330	firstName	user.attribute
3475c186-3632-4abc-ab95-9f64249d9330	true	id.token.claim
3475c186-3632-4abc-ab95-9f64249d9330	true	access.token.claim
3475c186-3632-4abc-ab95-9f64249d9330	given_name	claim.name
3475c186-3632-4abc-ab95-9f64249d9330	String	jsonType.label
57afb75f-0a3b-49d1-a4aa-c138426800e6	true	introspection.token.claim
57afb75f-0a3b-49d1-a4aa-c138426800e6	true	userinfo.token.claim
57afb75f-0a3b-49d1-a4aa-c138426800e6	birthdate	user.attribute
57afb75f-0a3b-49d1-a4aa-c138426800e6	true	id.token.claim
57afb75f-0a3b-49d1-a4aa-c138426800e6	true	access.token.claim
57afb75f-0a3b-49d1-a4aa-c138426800e6	birthdate	claim.name
57afb75f-0a3b-49d1-a4aa-c138426800e6	String	jsonType.label
66c7b01b-2e03-4b94-b8a2-6efd350c32e1	true	introspection.token.claim
66c7b01b-2e03-4b94-b8a2-6efd350c32e1	true	userinfo.token.claim
66c7b01b-2e03-4b94-b8a2-6efd350c32e1	true	id.token.claim
66c7b01b-2e03-4b94-b8a2-6efd350c32e1	true	access.token.claim
a327638c-8126-4716-80da-993f2ab7e85f	true	introspection.token.claim
a327638c-8126-4716-80da-993f2ab7e85f	true	userinfo.token.claim
a327638c-8126-4716-80da-993f2ab7e85f	middleName	user.attribute
a327638c-8126-4716-80da-993f2ab7e85f	true	id.token.claim
a327638c-8126-4716-80da-993f2ab7e85f	true	access.token.claim
a327638c-8126-4716-80da-993f2ab7e85f	middle_name	claim.name
a327638c-8126-4716-80da-993f2ab7e85f	String	jsonType.label
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	true	introspection.token.claim
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	true	userinfo.token.claim
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	lastName	user.attribute
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	true	id.token.claim
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	true	access.token.claim
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	family_name	claim.name
d98f78f6-be34-4e52-b4b7-e5477e1f44f4	String	jsonType.label
da5f8ef2-5114-48c1-97b8-9e66db14154e	true	introspection.token.claim
da5f8ef2-5114-48c1-97b8-9e66db14154e	true	userinfo.token.claim
da5f8ef2-5114-48c1-97b8-9e66db14154e	profile	user.attribute
da5f8ef2-5114-48c1-97b8-9e66db14154e	true	id.token.claim
da5f8ef2-5114-48c1-97b8-9e66db14154e	true	access.token.claim
da5f8ef2-5114-48c1-97b8-9e66db14154e	profile	claim.name
da5f8ef2-5114-48c1-97b8-9e66db14154e	String	jsonType.label
e4222c90-5b1b-47b5-9521-c0dbac527243	true	introspection.token.claim
e4222c90-5b1b-47b5-9521-c0dbac527243	true	userinfo.token.claim
e4222c90-5b1b-47b5-9521-c0dbac527243	username	user.attribute
e4222c90-5b1b-47b5-9521-c0dbac527243	true	id.token.claim
e4222c90-5b1b-47b5-9521-c0dbac527243	true	access.token.claim
e4222c90-5b1b-47b5-9521-c0dbac527243	preferred_username	claim.name
e4222c90-5b1b-47b5-9521-c0dbac527243	String	jsonType.label
f045a46e-04e9-49d3-9268-f6df0f8fea5d	true	introspection.token.claim
f045a46e-04e9-49d3-9268-f6df0f8fea5d	true	userinfo.token.claim
f045a46e-04e9-49d3-9268-f6df0f8fea5d	zoneinfo	user.attribute
f045a46e-04e9-49d3-9268-f6df0f8fea5d	true	id.token.claim
f045a46e-04e9-49d3-9268-f6df0f8fea5d	true	access.token.claim
f045a46e-04e9-49d3-9268-f6df0f8fea5d	zoneinfo	claim.name
f045a46e-04e9-49d3-9268-f6df0f8fea5d	String	jsonType.label
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	true	introspection.token.claim
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	true	userinfo.token.claim
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	website	user.attribute
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	true	id.token.claim
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	true	access.token.claim
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	website	claim.name
f8222e37-a6e0-4f8e-b11d-8d27fe13fa1d	String	jsonType.label
283fc441-43fb-4fb3-a901-72c80cc2a994	true	introspection.token.claim
283fc441-43fb-4fb3-a901-72c80cc2a994	true	userinfo.token.claim
283fc441-43fb-4fb3-a901-72c80cc2a994	emailVerified	user.attribute
283fc441-43fb-4fb3-a901-72c80cc2a994	true	id.token.claim
283fc441-43fb-4fb3-a901-72c80cc2a994	true	access.token.claim
283fc441-43fb-4fb3-a901-72c80cc2a994	email_verified	claim.name
283fc441-43fb-4fb3-a901-72c80cc2a994	boolean	jsonType.label
909eb95d-ea38-4137-b4d1-7b6cdb881342	true	introspection.token.claim
909eb95d-ea38-4137-b4d1-7b6cdb881342	true	userinfo.token.claim
909eb95d-ea38-4137-b4d1-7b6cdb881342	email	user.attribute
909eb95d-ea38-4137-b4d1-7b6cdb881342	true	id.token.claim
909eb95d-ea38-4137-b4d1-7b6cdb881342	true	access.token.claim
909eb95d-ea38-4137-b4d1-7b6cdb881342	email	claim.name
909eb95d-ea38-4137-b4d1-7b6cdb881342	String	jsonType.label
6e826527-154f-4f7f-a7ce-d9f815e95adf	formatted	user.attribute.formatted
6e826527-154f-4f7f-a7ce-d9f815e95adf	country	user.attribute.country
6e826527-154f-4f7f-a7ce-d9f815e95adf	true	introspection.token.claim
6e826527-154f-4f7f-a7ce-d9f815e95adf	postal_code	user.attribute.postal_code
6e826527-154f-4f7f-a7ce-d9f815e95adf	true	userinfo.token.claim
6e826527-154f-4f7f-a7ce-d9f815e95adf	street	user.attribute.street
6e826527-154f-4f7f-a7ce-d9f815e95adf	true	id.token.claim
6e826527-154f-4f7f-a7ce-d9f815e95adf	region	user.attribute.region
6e826527-154f-4f7f-a7ce-d9f815e95adf	true	access.token.claim
6e826527-154f-4f7f-a7ce-d9f815e95adf	locality	user.attribute.locality
315a31aa-2182-495a-b921-b94a92d20ccd	true	introspection.token.claim
315a31aa-2182-495a-b921-b94a92d20ccd	true	userinfo.token.claim
315a31aa-2182-495a-b921-b94a92d20ccd	phoneNumber	user.attribute
315a31aa-2182-495a-b921-b94a92d20ccd	true	id.token.claim
315a31aa-2182-495a-b921-b94a92d20ccd	true	access.token.claim
315a31aa-2182-495a-b921-b94a92d20ccd	phone_number	claim.name
315a31aa-2182-495a-b921-b94a92d20ccd	String	jsonType.label
58985bd0-f3bb-4bbe-a857-47c6878502e5	true	introspection.token.claim
58985bd0-f3bb-4bbe-a857-47c6878502e5	true	userinfo.token.claim
58985bd0-f3bb-4bbe-a857-47c6878502e5	phoneNumberVerified	user.attribute
58985bd0-f3bb-4bbe-a857-47c6878502e5	true	id.token.claim
58985bd0-f3bb-4bbe-a857-47c6878502e5	true	access.token.claim
58985bd0-f3bb-4bbe-a857-47c6878502e5	phone_number_verified	claim.name
58985bd0-f3bb-4bbe-a857-47c6878502e5	boolean	jsonType.label
10b0d34b-4563-44e1-8cbc-8bf04b6fe249	true	introspection.token.claim
10b0d34b-4563-44e1-8cbc-8bf04b6fe249	true	access.token.claim
22684229-d5cf-423a-9a7c-555329d5e709	true	introspection.token.claim
22684229-d5cf-423a-9a7c-555329d5e709	true	multivalued
22684229-d5cf-423a-9a7c-555329d5e709	foo	user.attribute
22684229-d5cf-423a-9a7c-555329d5e709	true	access.token.claim
22684229-d5cf-423a-9a7c-555329d5e709	resource_access.${client_id}.roles	claim.name
22684229-d5cf-423a-9a7c-555329d5e709	String	jsonType.label
9c76771e-ff36-4375-9337-9d5455e75bc1	true	introspection.token.claim
9c76771e-ff36-4375-9337-9d5455e75bc1	true	multivalued
9c76771e-ff36-4375-9337-9d5455e75bc1	foo	user.attribute
9c76771e-ff36-4375-9337-9d5455e75bc1	true	access.token.claim
9c76771e-ff36-4375-9337-9d5455e75bc1	realm_access.roles	claim.name
9c76771e-ff36-4375-9337-9d5455e75bc1	String	jsonType.label
99eaf32a-eafd-4134-8474-91d4cbcee105	true	introspection.token.claim
99eaf32a-eafd-4134-8474-91d4cbcee105	true	access.token.claim
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	true	introspection.token.claim
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	true	multivalued
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	foo	user.attribute
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	true	id.token.claim
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	true	access.token.claim
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	groups	claim.name
851f78f6-cd1f-4c86-b6d4-a776efd9ddf6	String	jsonType.label
8e7e5c47-640d-436b-afbb-727f9a531df6	true	introspection.token.claim
8e7e5c47-640d-436b-afbb-727f9a531df6	true	userinfo.token.claim
8e7e5c47-640d-436b-afbb-727f9a531df6	username	user.attribute
8e7e5c47-640d-436b-afbb-727f9a531df6	true	id.token.claim
8e7e5c47-640d-436b-afbb-727f9a531df6	true	access.token.claim
8e7e5c47-640d-436b-afbb-727f9a531df6	upn	claim.name
8e7e5c47-640d-436b-afbb-727f9a531df6	String	jsonType.label
4eaae0ab-5d4f-4fb0-b5e0-7d0c3eae5328	true	introspection.token.claim
4eaae0ab-5d4f-4fb0-b5e0-7d0c3eae5328	true	id.token.claim
4eaae0ab-5d4f-4fb0-b5e0-7d0c3eae5328	true	access.token.claim
088b12d0-baa6-4b63-8e20-1176af92efa9	AUTH_TIME	user.session.note
088b12d0-baa6-4b63-8e20-1176af92efa9	true	introspection.token.claim
088b12d0-baa6-4b63-8e20-1176af92efa9	true	id.token.claim
088b12d0-baa6-4b63-8e20-1176af92efa9	true	access.token.claim
088b12d0-baa6-4b63-8e20-1176af92efa9	auth_time	claim.name
088b12d0-baa6-4b63-8e20-1176af92efa9	long	jsonType.label
b85bb9db-6616-4126-a49d-8676e73c4a71	true	introspection.token.claim
b85bb9db-6616-4126-a49d-8676e73c4a71	true	access.token.claim
865d4c3b-3cad-4f10-af2c-ae11fb448046	clientAddress	user.session.note
865d4c3b-3cad-4f10-af2c-ae11fb448046	true	introspection.token.claim
865d4c3b-3cad-4f10-af2c-ae11fb448046	true	id.token.claim
865d4c3b-3cad-4f10-af2c-ae11fb448046	true	access.token.claim
865d4c3b-3cad-4f10-af2c-ae11fb448046	clientAddress	claim.name
865d4c3b-3cad-4f10-af2c-ae11fb448046	String	jsonType.label
d1be231f-a083-457e-b17e-591f0893d3ef	clientHost	user.session.note
d1be231f-a083-457e-b17e-591f0893d3ef	true	introspection.token.claim
d1be231f-a083-457e-b17e-591f0893d3ef	true	id.token.claim
d1be231f-a083-457e-b17e-591f0893d3ef	true	access.token.claim
d1be231f-a083-457e-b17e-591f0893d3ef	clientHost	claim.name
d1be231f-a083-457e-b17e-591f0893d3ef	String	jsonType.label
db82b5d5-4df0-457c-bd47-199848cbd9db	client_id	user.session.note
db82b5d5-4df0-457c-bd47-199848cbd9db	true	introspection.token.claim
db82b5d5-4df0-457c-bd47-199848cbd9db	true	id.token.claim
db82b5d5-4df0-457c-bd47-199848cbd9db	true	access.token.claim
db82b5d5-4df0-457c-bd47-199848cbd9db	client_id	claim.name
db82b5d5-4df0-457c-bd47-199848cbd9db	String	jsonType.label
3298c451-8abd-4735-87c9-58083fbf7e88	true	introspection.token.claim
3298c451-8abd-4735-87c9-58083fbf7e88	true	multivalued
3298c451-8abd-4735-87c9-58083fbf7e88	true	id.token.claim
3298c451-8abd-4735-87c9-58083fbf7e88	true	access.token.claim
3298c451-8abd-4735-87c9-58083fbf7e88	organization	claim.name
3298c451-8abd-4735-87c9-58083fbf7e88	String	jsonType.label
4d134a7c-9680-4f79-8315-7d66e985b0cc	true	introspection.token.claim
4d134a7c-9680-4f79-8315-7d66e985b0cc	true	userinfo.token.claim
4d134a7c-9680-4f79-8315-7d66e985b0cc	locale	user.attribute
4d134a7c-9680-4f79-8315-7d66e985b0cc	true	id.token.claim
4d134a7c-9680-4f79-8315-7d66e985b0cc	true	access.token.claim
4d134a7c-9680-4f79-8315-7d66e985b0cc	locale	claim.name
4d134a7c-9680-4f79-8315-7d66e985b0cc	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
82225a6e-13a1-44cf-a86f-129f1a907c0b	60	300	300	\N	\N	\N	t	f	0	\N	individuals	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	e24cff59-2e0b-4ef6-9991-8b3e62a43178	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	538905a2-b036-4dff-a7d5-1ee5c0925f1d	ba3d4c6b-fd2f-4cd9-a5f2-29484f732a61	f6d772c3-220e-4f81-ba59-1c5b848b40d7	6b8630ce-2b50-46a0-8eb3-35ce0f137577	3fdd4a2a-426e-48d6-be02-55d72931ccdc	2592000	f	900	t	f	da879fd4-5cd9-4699-b679-ae0b24fad1bd	0	f	0	0	28ab4178-1456-400b-b111-ac217c87c5b1
62548a37-f59d-45a0-adc9-27061011b0f3	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	ad33cbcc-60d2-4d26-9439-45956e8095fc	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f616f338-c4c6-423d-ae7f-96f394153f27	151a8c2d-0e03-4aa2-8f42-3d49b50b366d	dc77fc60-7c97-4461-9ff1-9c688e1cb1f6	4119f2bc-fc86-4563-864b-42878875f4c0	33eec804-68e5-46fd-a512-7e62146cb455	2592000	f	900	t	f	23fe7204-25aa-4c94-b62c-fb84bf755542	0	f	0	0	9a1e973a-a791-42b1-9b1c-98dbee5b61c1
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	62548a37-f59d-45a0-adc9-27061011b0f3	
_browser_header.xContentTypeOptions	62548a37-f59d-45a0-adc9-27061011b0f3	nosniff
_browser_header.referrerPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	no-referrer
_browser_header.xRobotsTag	62548a37-f59d-45a0-adc9-27061011b0f3	none
_browser_header.xFrameOptions	62548a37-f59d-45a0-adc9-27061011b0f3	SAMEORIGIN
_browser_header.contentSecurityPolicy	62548a37-f59d-45a0-adc9-27061011b0f3	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	62548a37-f59d-45a0-adc9-27061011b0f3	max-age=31536000; includeSubDomains
bruteForceProtected	62548a37-f59d-45a0-adc9-27061011b0f3	false
permanentLockout	62548a37-f59d-45a0-adc9-27061011b0f3	false
maxTemporaryLockouts	62548a37-f59d-45a0-adc9-27061011b0f3	0
bruteForceStrategy	62548a37-f59d-45a0-adc9-27061011b0f3	MULTIPLE
maxFailureWaitSeconds	62548a37-f59d-45a0-adc9-27061011b0f3	900
minimumQuickLoginWaitSeconds	62548a37-f59d-45a0-adc9-27061011b0f3	60
waitIncrementSeconds	62548a37-f59d-45a0-adc9-27061011b0f3	60
quickLoginCheckMilliSeconds	62548a37-f59d-45a0-adc9-27061011b0f3	1000
maxDeltaTimeSeconds	62548a37-f59d-45a0-adc9-27061011b0f3	43200
failureFactor	62548a37-f59d-45a0-adc9-27061011b0f3	30
realmReusableOtpCode	62548a37-f59d-45a0-adc9-27061011b0f3	false
firstBrokerLoginFlowId	62548a37-f59d-45a0-adc9-27061011b0f3	c5de7363-3d60-4a91-ac3a-f4e477354f89
displayName	62548a37-f59d-45a0-adc9-27061011b0f3	Keycloak
displayNameHtml	62548a37-f59d-45a0-adc9-27061011b0f3	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	62548a37-f59d-45a0-adc9-27061011b0f3	RS256
offlineSessionMaxLifespanEnabled	62548a37-f59d-45a0-adc9-27061011b0f3	false
offlineSessionMaxLifespan	62548a37-f59d-45a0-adc9-27061011b0f3	5184000
_browser_header.contentSecurityPolicyReportOnly	82225a6e-13a1-44cf-a86f-129f1a907c0b	
_browser_header.xContentTypeOptions	82225a6e-13a1-44cf-a86f-129f1a907c0b	nosniff
_browser_header.referrerPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	no-referrer
_browser_header.xRobotsTag	82225a6e-13a1-44cf-a86f-129f1a907c0b	none
_browser_header.xFrameOptions	82225a6e-13a1-44cf-a86f-129f1a907c0b	SAMEORIGIN
_browser_header.contentSecurityPolicy	82225a6e-13a1-44cf-a86f-129f1a907c0b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	82225a6e-13a1-44cf-a86f-129f1a907c0b	max-age=31536000; includeSubDomains
bruteForceProtected	82225a6e-13a1-44cf-a86f-129f1a907c0b	false
permanentLockout	82225a6e-13a1-44cf-a86f-129f1a907c0b	false
maxTemporaryLockouts	82225a6e-13a1-44cf-a86f-129f1a907c0b	0
bruteForceStrategy	82225a6e-13a1-44cf-a86f-129f1a907c0b	MULTIPLE
maxFailureWaitSeconds	82225a6e-13a1-44cf-a86f-129f1a907c0b	900
minimumQuickLoginWaitSeconds	82225a6e-13a1-44cf-a86f-129f1a907c0b	60
waitIncrementSeconds	82225a6e-13a1-44cf-a86f-129f1a907c0b	60
quickLoginCheckMilliSeconds	82225a6e-13a1-44cf-a86f-129f1a907c0b	1000
maxDeltaTimeSeconds	82225a6e-13a1-44cf-a86f-129f1a907c0b	43200
failureFactor	82225a6e-13a1-44cf-a86f-129f1a907c0b	30
realmReusableOtpCode	82225a6e-13a1-44cf-a86f-129f1a907c0b	false
defaultSignatureAlgorithm	82225a6e-13a1-44cf-a86f-129f1a907c0b	RS256
offlineSessionMaxLifespanEnabled	82225a6e-13a1-44cf-a86f-129f1a907c0b	false
offlineSessionMaxLifespan	82225a6e-13a1-44cf-a86f-129f1a907c0b	5184000
actionTokenGeneratedByAdminLifespan	82225a6e-13a1-44cf-a86f-129f1a907c0b	43200
actionTokenGeneratedByUserLifespan	82225a6e-13a1-44cf-a86f-129f1a907c0b	300
oauth2DeviceCodeLifespan	82225a6e-13a1-44cf-a86f-129f1a907c0b	600
oauth2DevicePollingInterval	82225a6e-13a1-44cf-a86f-129f1a907c0b	5
webAuthnPolicyRpEntityName	82225a6e-13a1-44cf-a86f-129f1a907c0b	keycloak
webAuthnPolicySignatureAlgorithms	82225a6e-13a1-44cf-a86f-129f1a907c0b	ES256,RS256
webAuthnPolicyRpId	82225a6e-13a1-44cf-a86f-129f1a907c0b	
webAuthnPolicyAttestationConveyancePreference	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyAuthenticatorAttachment	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyRequireResidentKey	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyUserVerificationRequirement	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyCreateTimeout	82225a6e-13a1-44cf-a86f-129f1a907c0b	0
webAuthnPolicyAvoidSameAuthenticatorRegister	82225a6e-13a1-44cf-a86f-129f1a907c0b	false
webAuthnPolicyRpEntityNamePasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	ES256,RS256
webAuthnPolicyRpIdPasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	
webAuthnPolicyAttestationConveyancePreferencePasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyRequireResidentKeyPasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	not specified
webAuthnPolicyCreateTimeoutPasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	false
cibaBackchannelTokenDeliveryMode	82225a6e-13a1-44cf-a86f-129f1a907c0b	poll
cibaExpiresIn	82225a6e-13a1-44cf-a86f-129f1a907c0b	120
cibaInterval	82225a6e-13a1-44cf-a86f-129f1a907c0b	5
cibaAuthRequestedUserHint	82225a6e-13a1-44cf-a86f-129f1a907c0b	login_hint
parRequestUriLifespan	82225a6e-13a1-44cf-a86f-129f1a907c0b	60
firstBrokerLoginFlowId	82225a6e-13a1-44cf-a86f-129f1a907c0b	ed7872c1-7f43-432a-a08c-1ce740b43000
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
62548a37-f59d-45a0-adc9-27061011b0f3	jboss-logging
82225a6e-13a1-44cf-a86f-129f1a907c0b	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	62548a37-f59d-45a0-adc9-27061011b0f3
password	password	t	t	82225a6e-13a1-44cf-a86f-129f1a907c0b
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
97a41e0d-7fc5-4654-81ca-1dbe6a8e7f46	/realms/master/account/*
d8fcc746-02b4-40c5-8868-ab2ad6036800	/realms/master/account/*
ec343f09-000f-4118-bd65-b627552fda3d	/admin/master/console/*
96a5665e-3543-4736-9605-1cae60ce7016	/realms/individuals/account/*
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	/realms/individuals/account/*
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	/admin/individuals/console/*
50d26acd-9eea-4f82-865e-16a8cfc79cff	http://localhost:8092/*
50d26acd-9eea-4f82-865e-16a8cfc79cff	https://oauth.pstmn.io/v1/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
a636cedb-61ce-4719-a64c-3dc566a9ff20	VERIFY_EMAIL	Verify Email	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	VERIFY_EMAIL	50
cc250eee-c248-4ba1-9616-869591d21678	UPDATE_PROFILE	Update Profile	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	UPDATE_PROFILE	40
4eb186a9-beac-4e51-a140-12f21ddd7ea4	CONFIGURE_TOTP	Configure OTP	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	CONFIGURE_TOTP	10
c55c9096-002d-42c0-90b2-dc47bc535fd8	UPDATE_PASSWORD	Update Password	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	UPDATE_PASSWORD	30
18f9968d-bc69-4dc9-971c-4f0e3966d662	TERMS_AND_CONDITIONS	Terms and Conditions	62548a37-f59d-45a0-adc9-27061011b0f3	f	f	TERMS_AND_CONDITIONS	20
cbcfe5c5-82f9-4244-84d2-f1c7413e0a08	delete_account	Delete Account	62548a37-f59d-45a0-adc9-27061011b0f3	f	f	delete_account	60
78119453-d1cc-42cc-9302-e632fd492676	delete_credential	Delete Credential	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	delete_credential	100
0c9fec8e-df3d-4dea-a76d-b64f93a057b6	update_user_locale	Update User Locale	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	update_user_locale	1000
f54405c0-2d30-45a6-9f8c-68cb5e853d92	webauthn-register	Webauthn Register	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	webauthn-register	70
70c11cfc-1f2f-439f-b533-82e522c12b9c	webauthn-register-passwordless	Webauthn Register Passwordless	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	webauthn-register-passwordless	80
cabd0920-c5a0-4518-ace6-142ff0f7c643	VERIFY_PROFILE	Verify Profile	62548a37-f59d-45a0-adc9-27061011b0f3	t	f	VERIFY_PROFILE	90
6a6d4383-8f64-46a2-90e3-5592db9bc1fb	VERIFY_EMAIL	Verify Email	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	VERIFY_EMAIL	50
90792156-2d77-4a02-b35b-525af9990f8c	UPDATE_PROFILE	Update Profile	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	UPDATE_PROFILE	40
27011e0b-a624-49cc-83d9-7d5d1ca376aa	CONFIGURE_TOTP	Configure OTP	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	CONFIGURE_TOTP	10
874d9a8d-c019-4054-94bc-e644c2111079	UPDATE_PASSWORD	Update Password	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	UPDATE_PASSWORD	30
ba61746e-77a3-4cf5-8c7c-a69c36e49c2c	TERMS_AND_CONDITIONS	Terms and Conditions	82225a6e-13a1-44cf-a86f-129f1a907c0b	f	f	TERMS_AND_CONDITIONS	20
310c4d15-a4f1-4283-ab54-fb40c5256a40	delete_account	Delete Account	82225a6e-13a1-44cf-a86f-129f1a907c0b	f	f	delete_account	60
27ec1eb5-f3eb-49af-8879-c6af9fb629ca	delete_credential	Delete Credential	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	delete_credential	100
e8e90752-fa9e-45f3-8d9e-8424b6b7dbd1	update_user_locale	Update User Locale	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	update_user_locale	1000
b6cced83-ea71-4bcb-92d5-13cff092092e	webauthn-register	Webauthn Register	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	webauthn-register	70
68be2556-ac90-4489-9952-cdee9ddba4a3	webauthn-register-passwordless	Webauthn Register Passwordless	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	webauthn-register-passwordless	80
af0673a3-780f-48d7-afaf-561f597b8c79	VERIFY_PROFILE	Verify Profile	82225a6e-13a1-44cf-a86f-129f1a907c0b	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
50d26acd-9eea-4f82-865e-16a8cfc79cff	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
8355087a-9dd9-4cc4-b248-fadb89e47fa6	Default Policy	A policy that grants access only for users within this realm	js	0	0	50d26acd-9eea-4f82-865e-16a8cfc79cff	\N
756b6c8b-fab4-4ec1-9de6-2b22fc628505	Default Permission	A permission that applies to the default resource type	resource	1	0	50d26acd-9eea-4f82-865e-16a8cfc79cff	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
77c6be6e-04bf-4688-bb97-50bd0c2c49e3	Default Resource	urn:individuals:resources:default	\N	50d26acd-9eea-4f82-865e-16a8cfc79cff	50d26acd-9eea-4f82-865e-16a8cfc79cff	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
77c6be6e-04bf-4688-bb97-50bd0c2c49e3	/*
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
d8fcc746-02b4-40c5-8868-ab2ad6036800	a3abd72f-91da-4182-92f5-ce7c61d84a8f
d8fcc746-02b4-40c5-8868-ab2ad6036800	7299c2f7-e54a-4a14-bf11-363f519b7dc8
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	7c6e8fbc-b10e-4a7e-a200-09ccdaaf9089
f35a3398-1aad-4f3b-94f5-da5ebefb53f1	cf704fae-bb60-479b-80f4-782522c39dee
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	15ba18d0-6425-458d-b770-0d79bf84fce8	1d96799b-02a0-4990-94bf-23d371a72d0d	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
15ba18d0-6425-458d-b770-0d79bf84fce8	\N	0a472864-0bb6-434c-8d0b-fd5ebec7f6ab	f	t	\N	\N	\N	62548a37-f59d-45a0-adc9-27061011b0f3	admin	1748453661195	\N	0
9a659f09-1ab9-4573-a644-0d5956e7e229	admin@mail.com	admin@mail.com	t	t	\N	Eugene	S	82225a6e-13a1-44cf-a86f-129f1a907c0b	admin	1748621220068	\N	0
17cf267f-9cda-475b-ab61-a3217bcc08fa	user@mail.com	user@mail.com	t	t	\N	Roman	K	82225a6e-13a1-44cf-a86f-129f1a907c0b	user	1748621255324	\N	0
f6038f65-9670-4e06-b04f-db6d750922c3	\N	efbe79a4-65a2-4971-af60-c05ecdbbbdb1	f	t	\N	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	service-account-individuals	1748622367215	50d26acd-9eea-4f82-865e-16a8cfc79cff	0
f3ddab43-ceb7-4e1e-b387-1223601fd8fe	user@gmail.com	user@gmail.com	f	t	\N	\N	\N	82225a6e-13a1-44cf-a86f-129f1a907c0b	user@gmail.com	1748894711159	\N	0
fd74e914-ff19-44b7-8256-c437d2dfdac8	qqq@gmail.com	qqq@gmail.com	t	t	\N	Dasd	Dasdasd	82225a6e-13a1-44cf-a86f-129f1a907c0b	qqq@gmail.com	1748896593997	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
9a1e973a-a791-42b1-9b1c-98dbee5b61c1	15ba18d0-6425-458d-b770-0d79bf84fce8
2cd307ed-2746-493a-9540-377bf9a4811f	15ba18d0-6425-458d-b770-0d79bf84fce8
28ab4178-1456-400b-b111-ac217c87c5b1	9a659f09-1ab9-4573-a644-0d5956e7e229
28ab4178-1456-400b-b111-ac217c87c5b1	17cf267f-9cda-475b-ab61-a3217bcc08fa
28ab4178-1456-400b-b111-ac217c87c5b1	f6038f65-9670-4e06-b04f-db6d750922c3
fe515c56-c3f2-4ae8-9394-99c3cc05dc20	f6038f65-9670-4e06-b04f-db6d750922c3
a40965a6-39a2-4896-8d7f-27e7ea98f76a	9a659f09-1ab9-4573-a644-0d5956e7e229
28ab4178-1456-400b-b111-ac217c87c5b1	f3ddab43-ceb7-4e1e-b387-1223601fd8fe
28ab4178-1456-400b-b111-ac217c87c5b1	fd74e914-ff19-44b7-8256-c437d2dfdac8
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
ec343f09-000f-4118-bd65-b627552fda3d	+
2b5206cd-85af-41b4-a12f-a3cdc5e37ccb	+
50d26acd-9eea-4f82-865e-16a8cfc79cff	http://localhost:8092
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--


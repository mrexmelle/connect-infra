CREATE DATABASE orgs;
CREATE USER orgs_r WITH PASSWORD '123';
CREATE USER orgs_w WITH PASSWORD '123';
GRANT CONNECT ON DATABASE orgs TO orgs_r;
GRANT CONNECT ON DATABASE orgs TO orgs_w;

\c orgs;

CREATE EXTENSION pgcrypto;

CREATE TABLE IF NOT EXISTS organizations(
	id TEXT NOT NULL,
	hierarchy TEXT NOT NULL,
	name TEXT NOT NULL,
	email_address TEXT,
	private_slack_channel TEXT,
	public_slack_channel TEXT,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	deleted_at TIMESTAMPTZ DEFAULT NULL,
	CONSTRAINT pk_organizations PRIMARY KEY(id)
);
GRANT SELECT ON organizations TO orgs_r;
GRANT SELECT, UPDATE, INSERT, DELETE ON organizations TO orgs_w;

CREATE TABLE IF NOT EXISTS roles(
    id TEXT NOT NULL,
    name TEXT NOT NULL,
    rank INTEGER DEFAULT 2147483647,
	max_count INTEGER DEFAULT -1,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	deleted_at TIMESTAMPTZ DEFAULT NULL,
	CONSTRAINT pk_roles PRIMARY KEY(id),
	CONSTRAINT un_roles UNIQUE(name)
);
GRANT SELECT ON roles TO orgs_r;
GRANT SELECT, UPDATE, INSERT, DELETE ON roles TO orgs_w;

CREATE TABLE IF NOT EXISTS placements(
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    organization_id TEXT NOT NULL,
	role_id TEXT NOT NULL,
	ehid TEXT NOT NULL,
	created_at TIMESTAMPTZ NOT NULL,
	updated_at TIMESTAMPTZ NOT NULL,
	deleted_at TIMESTAMPTZ DEFAULT NULL,
	CONSTRAINT pk_placements PRIMARY KEY(id),
	CONSTRAINT fk_placements_1 FOREIGN KEY(organization_id) REFERENCES organizations(id),
	CONSTRAINT fk_placements_2 FOREIGN KEY(role_id) REFERENCES roles(id)
);
GRANT SELECT ON placements TO orgs_r;
GRANT SELECT, UPDATE, INSERT, DELETE ON placements TO orgs_w;

-- Alter table for namespace set (bitwise) support

-- Comma separated list of namespaces that apply to this country record (e.g. "namespace1,namespace2"), the index of each namespace in the list corresponds to a bit position in the spaceset.
ALTER TABLE sys_country ADD COLUMN namespaces VARCHAR(128);

ALTER TABLE sys_division ADD COLUMN namespaceset INTEGER DEFAULT 0;
ALTER TABLE sys_division_sub ADD COLUMN namespaceset INTEGER DEFAULT 0;
ALTER TABLE sys_prefix ADD COLUMN namespaceset INTEGER DEFAULT 0;
ALTER TABLE sys_prefix RENAME COLUMN Name TO "name";

-- Unique index on (division_cd, namespaceset) to allow same division_cd in different namespaces
DROP INDEX IF EXISTS division_unique_iso;
CREATE UNIQUE INDEX division_unique_iso ON sys_division(division_cd, namespaceset);


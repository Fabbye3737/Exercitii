create extension postgis;

create table if not exists parc(
	fid serial primary key,
	nume varchar (100) not null,
	scop varchar (100) null,
	geom geometry ('Polygon', 4326) not null
);

create table if not exists evenimente(
	fid serial primary key,
	tip_eveniment varchar (100) not null,
	data date null
);

create table evenimente_parc(
	fid serial primary key,
	parc_fid integer not null,
	evenimente_fid integer not null,
	foreign key(parc_fid) references parc(fid),
	foreign key(evenimente_fid) references evenimente(fid)
);

create table if not exists sistem_irigare(
	fid serial primary key,
	parc_fid integer not null,
	numar_conducte integer not null,
	geom geometry ('LineString', 4326) not null,
	foreign key(parc_fid) references parc(fid)
);

create table if not exists alei(
	fid serial primary key,
	parc_fid integer not null,
	latime_m smallint not null,
	lungime_m integer not null,
	geom geometry ('LineString', 4326) not null,
	foreign key(parc_fid) references parc(fid)
);

create table if not exists mobilier_urban(
	fid serial primary key,
	parc_fid integer not null,
	tip_mobilier varchar not null,
	scop varchar not null,
	geom geometry ('Point', 4326) not null,
	foreign key(parc_fid) references parc(fid)
);

create table if not exists constructii(
	fid serial primary key,
	parc_fid integer not null,
	tip_consctructie varchar not null,
	geom geometry ('Point', 4326) not null,
	foreign key(parc_fid) references parc(fid)
);

create table if not exists vegetatie(
	fid serial primary key,
	parc_fid integer not null,
	tip_vegetatie varchar not null,
	permanenta bool not null,
	geom geometry ('Point', 4326) not null,
	foreign key(parc_fid) references parc(fid)
);

create table if not exists salubritate(
	fid serial primary key,
	parc_fid integer not null,
	nume_companie varchar not null,
	foreign key(parc_fid) references parc(fid)
);

Select fid, ST_Area(geom) as area, ST_Perimeter(geom) as perimeter from parc;

Select fid, ST_AsText(ST_Centroid(geom)) as centroid from parc;

Select fid, ST_Length(geom) as length from alei;
create database Pokemon
go

use Pokemon


create table PokemonType(
	Id uniqueidentifier not null,
	Name nvarchar(20) not null

	constraint poke_type_pk primary key (Id)
)

create table Pokemon(
	Id uniqueidentifier not null,
	Name nvarchar(50) not null,
	PokemonType uniqueidentifier not null,
	Evolution uniqueidentifier null

	constraint poke_pk primary key (id)
	constraint poke_type_fk foreign key (PokemonType) references PokemonType(id), 
	constraint poke_evolution_fk foreign key (Evolution) references Pokemon(id)
)

create table PokemonDetails(
	PokemonId uniqueidentifier not null primary key,
	Attack int not null,
	Life int not null,
	PokemonTypeWeakness uniqueidentifier null foreign key references PokemonType(id),
	PokemonWeaknessMultiplier decimal(3,2) null,

	constraint poke_details_poke_fk foreign key (PokemonId) references Pokemon(id)
)


create table Trainer(
	Id uniqueidentifier not null primary key,
	Name nvarchar(50) not null,
	Surname nvarchar(50) null,
	BirthDate Date not null
)

create table PokemonCharacter(
	Id uniqueidentifier not null primary key,
	Nickname nvarchar(50) null,
	PokemonId uniqueidentifier not null foreign key references Pokemon(id),
	TrainerId uniqueidentifier not null foreign key references Trainer(id)
)


create table Gym(
	Id uniqueidentifier not null primary key,
	Name nvarchar(50) not null,
	Leader uniqueidentifier not null foreign key references Trainer(id)
)

create table GymTrainer(
	GymId uniqueidentifier not null,
	TrainerId uniqueidentifier not null,

	foreign key (GymId) references Gym(id),
	foreign key (TrainerId) references Trainer(Id),
	unique(GymId, TrainerId)
);

declare @WaterTypeTypeId uniqueidentifier = newid(),
		@FireTypeTypeId uniqueidentifier = newid(),
		@GrassTypeTypeId uniqueidentifier = newid(),
		@ElectricTypeId uniqueidentifier = newId();

insert into PokemonType values (@WaterTypeTypeId, 'Water')
insert into PokemonType values (@FireTypeTypeId, 'Fire')
insert into PokemonType values (@GrassTypeTypeId, 'Grass')
insert into PokemonType values (@ElectricTypeId, 'Electric')

declare @CharmanderId uniqueidentifier = newId(),
		@CharmeleonId uniqueidentifier = newId(),
		@CharizardId uniqueidentifier = newId(),
		@BulbasaurId uniqueidentifier = newId(),
		@IvySaur uniqueidentifier = newId(),
		@Venusaur uniqueidentifier = newId(),
		@SquirtleId uniqueidentifier = newId(),
		@WartortleId uniqueidentifier = newId(),
		@Blastoise uniqueidentifier = newId(),
		@Pichu uniqueidentifier = newid(),
		@Picachu uniqueidentifier = newId(),
		@Raichu uniqueidentifier = newId();

insert into Pokemon values(@CharizardId, 'Charizard', @FireTypeTypeId, null)
insert into Pokemon values(@CharmeleonId, 'Charmeleon', @FireTypeTypeId, @CharizardId)
Insert into Pokemon Values(@CharmanderId, 'Charmander', @FireTypeTypeId, @CharmeleonId)

insert into Pokemon values(@Venusaur, 'Venusaur', @GrassTypeTypeId, null)
insert into Pokemon values(@IvySaur, 'Ivysaur', @GrassTypeTypeId, @Venusaur)
insert into Pokemon values(@BulbasaurId, 'Bulbasaur', @GrassTypeTypeId, @IvySaur)

insert into Pokemon values(@Blastoise, 'Blastoise', @WaterTypeTypeId, null)
insert into Pokemon values(@WartortleId, 'Wartortle', @WaterTypeTypeId, @Blastoise)
insert into Pokemon values(@SquirtleId, 'Squirtle', @WaterTypeTypeId, @WartortleId)

insert into Pokemon values(@Raichu, 'Raichu', @ElectricTypeId, null)
insert into Pokemon values(@Picachu, 'Pikachu', @ElectricTypeId, @Raichu)
insert into Pokemon values(@Pichu, 'Pichu', @ElectricTypeId, @Picachu)


insert into PokemonDetails values(@CharmanderId, 10, 20, @WaterTypeTypeId, 1.50)
insert into PokemonDetails values(@CharmeleonId, 15, 40, @WaterTypeTypeId, 1.70)
insert into PokemonDetails values(@CharizardId, 20, 60, @WaterTypeTypeId, 1.75)

insert into PokemonDetails values(@BulbasaurId, 5, 30, @FireTypeTypeId, 1.9)
insert into PokemonDetails values(@IvySaur, 11, 50, @FireTypeTypeId, 2.00)
insert into PokemonDetails values(@Venusaur, 15, 80, @FireTypeTypeId, 2.00)


insert into PokemonDetails values(@SquirtleId, 10, 20, @ElectricTypeId, 1.5)
insert into PokemonDetails values(@WartortleId, 15, 40, @ElectricTypeId, 1.7)
insert into PokemonDetails values(@Blastoise, 20, 60, @ElectricTypeId, 1.75)

insert into PokemonDetails values(@Pichu, 5, 20, @GrassTypeTypeId, 1.5)
insert into PokemonDetails values(@Picachu, 15, 40, @GrassTypeTypeId, 1.7)
insert into PokemonDetails values(@Raichu, 30, 50, @GrassTypeTypeId, 1.75)

declare @ashId uniqueidentifier = newid(),
		@redId uniqueidentifier = newid(),
		@blueId uniqueidentifier = newid();

insert into Trainer values(@ashId, 'Ash', 'Ketchum', dateadd(year, -15, getdate()))
insert into Trainer values(@redId, 'Red', null, dateadd(year, -16, getdate()))
insert into Trainer values(@blueId, 'Blue', null, dateadd(year, -14, getdate()))

declare @gym1 uniqueidentifier = newid(),
		@gym2 uniqueidentifier = newid(),
		@gym3 uniqueidentifier = newId()

insert into Gym values(@gym1, 'Gym 1', @ashId)
insert into Gym values(@gym2, 'Gym 2', @redId)
insert into Gym values(@gym3, 'Gym 3', @blueId)

insert into GymTrainer values (@gym1, @ashId)
insert into GymTrainer values (@gym1, @redId)
insert into GymTrainer values (@gym1, @blueId)

insert into GymTrainer values (@gym2, @ashId)
insert into GymTrainer values (@gym2, @redId)
insert into GymTrainer values (@gym2, @blueId)

insert into GymTrainer values (@gym3, @redId)
insert into GymTrainer values (@gym3, @blueId)


insert into PokemonCharacter values (newid(), 'Pikachu', @Picachu, @ashId)
insert into PokemonCharacter values (newid(), 'Charizard', @CharizardId, @ashId)
insert into PokemonCharacter values (newid(), 'Blastoise', @Blastoise, @ashId)


insert into PokemonCharacter values (newid(), 'Charizard', @CharizardId, @redId)
insert into PokemonCharacter values (newid(), 'Charmeleon', @CharmeleonId, @redId)
insert into PokemonCharacter values (newid(), 'Raichu', @Raichu, @redId)

insert into PokemonCharacter values (newid(), 'Blastoise', @Blastoise, @blueId)
insert into PokemonCharacter values (newid(), 'Bulbasaur', @BulbasaurId, @blueId)
insert into PokemonCharacter values (newid(), 'Venusaur', @Venusaur, @blueId)


select * from Gym;
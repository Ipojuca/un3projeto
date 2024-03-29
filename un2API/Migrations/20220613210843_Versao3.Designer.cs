﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using un2API.Context;

#nullable disable

namespace un2API.Migrations
{
    [DbContext(typeof(AppDBContext))]
    [Migration("20220613210843_Versao3")]
    partial class Versao3
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "6.0.5");

            modelBuilder.Entity("un2API.Models.Projeto", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("Descricao")
                        .HasColumnType("TEXT");

                    b.Property<DateTime>("Prazo")
                        .HasColumnType("TEXT");

                    b.Property<string>("Titulo")
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("Projetos");
                });

            modelBuilder.Entity("un2API.Models.Tarefa", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("Descricao")
                        .HasColumnType("TEXT");

                    b.Property<int>("ProjetoId")
                        .HasColumnType("INTEGER");

                    b.Property<int>("UsuarioId")
                        .HasColumnType("INTEGER");

                    b.HasKey("Id");

                    b.HasIndex("ProjetoId");

                    b.HasIndex("UsuarioId");

                    b.ToTable("Tarefas");
                });

            modelBuilder.Entity("un2API.Models.Usuario", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("Email")
                        .HasColumnType("TEXT");

                    b.Property<string>("Nome")
                        .HasColumnType("TEXT");

                    b.HasKey("Id");

                    b.ToTable("Usuarios");
                });

            modelBuilder.Entity("un2API.Models.Tarefa", b =>
                {
                    b.HasOne("un2API.Models.Projeto", null)
                        .WithMany("Tarefas")
                        .HasForeignKey("ProjetoId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("un2API.Models.Usuario", "Usuario")
                        .WithMany()
                        .HasForeignKey("UsuarioId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Usuario");
                });

            modelBuilder.Entity("un2API.Models.Projeto", b =>
                {
                    b.Navigation("Tarefas");
                });
#pragma warning restore 612, 618
        }
    }
}

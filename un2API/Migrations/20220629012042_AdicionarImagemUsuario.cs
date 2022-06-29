using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace un2API.Migrations
{
    public partial class AdicionarImagemUsuario : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "Imagem",
                table: "Usuarios",
                type: "BLOB",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Imagem",
                table: "Usuarios");
        }
    }
}

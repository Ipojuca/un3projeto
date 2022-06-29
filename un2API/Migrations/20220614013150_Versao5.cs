using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace un2API.Migrations
{
    public partial class Versao5 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Tarefas_Usuarios_CreatedById",
                table: "Tarefas");

            migrationBuilder.DropIndex(
                name: "IX_Tarefas_CreatedById",
                table: "Tarefas");

            migrationBuilder.DropColumn(
                name: "CreatedById",
                table: "Tarefas");

            migrationBuilder.CreateIndex(
                name: "IX_Tarefas_UsuarioId",
                table: "Tarefas",
                column: "UsuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Tarefas_Usuarios_UsuarioId",
                table: "Tarefas",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Tarefas_Usuarios_UsuarioId",
                table: "Tarefas");

            migrationBuilder.DropIndex(
                name: "IX_Tarefas_UsuarioId",
                table: "Tarefas");

            migrationBuilder.AddColumn<int>(
                name: "CreatedById",
                table: "Tarefas",
                type: "INTEGER",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Tarefas_CreatedById",
                table: "Tarefas",
                column: "CreatedById");

            migrationBuilder.AddForeignKey(
                name: "FK_Tarefas_Usuarios_CreatedById",
                table: "Tarefas",
                column: "CreatedById",
                principalTable: "Usuarios",
                principalColumn: "Id");
        }
    }
}

using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace un2API.Migrations
{
    public partial class Versao2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Tarefas_Usuarios_usuarioId",
                table: "Tarefas");

            migrationBuilder.DropIndex(
                name: "IX_Tarefas_usuarioId",
                table: "Tarefas");

            migrationBuilder.RenameColumn(
                name: "usuarioId",
                table: "Tarefas",
                newName: "UsuarioId");

            migrationBuilder.AlterColumn<int>(
                name: "UsuarioId",
                table: "Tarefas",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "INTEGER",
                oldNullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "UsuarioId",
                table: "Tarefas",
                newName: "usuarioId");

            migrationBuilder.AlterColumn<int>(
                name: "usuarioId",
                table: "Tarefas",
                type: "INTEGER",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "INTEGER");

            migrationBuilder.CreateIndex(
                name: "IX_Tarefas_usuarioId",
                table: "Tarefas",
                column: "usuarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_Tarefas_Usuarios_usuarioId",
                table: "Tarefas",
                column: "usuarioId",
                principalTable: "Usuarios",
                principalColumn: "Id");
        }
    }
}

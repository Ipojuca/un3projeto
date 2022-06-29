using Microsoft.EntityFrameworkCore;
using un2API.Models;

namespace un2API.Context
{
    public class AppDBContext : DbContext
    {

        public AppDBContext(DbContextOptions options) : base(options) { }
        public DbSet<Projeto> Projetos => Set<Projeto>();
        public DbSet<Tarefa> Tarefas => Set<Tarefa>();
        public DbSet<Usuario> Usuarios => Set<Usuario>();

    }
}

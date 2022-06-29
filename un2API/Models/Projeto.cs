namespace un2API.Models
{
    public class Projeto
    {
        public int Id { get; set; }
        public string? Titulo { get; set; }
        public DateTime Prazo { get; set; }
        public string? Descricao { get; set; }

        public ICollection<Tarefa>? Tarefas { get; set; }

    }
}

﻿namespace un2API.Models
{

    public class Usuario
    {
        public int Id { get; set; }
        public string? Nome { get; set; }
        public string? Email { get; set; }
        public byte[]? Imagem { get; set; }

        //public ICollection<Tarefa>? Tarefas { get; set; }
    }
}

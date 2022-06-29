using Microsoft.EntityFrameworkCore;
using un2API.Context;
using un2API.Models;

var builder = WebApplication.CreateBuilder(args);

var connectString = builder.Configuration.GetConnectionString("Projetos") ?? "Data Source=Projetos.db";

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//builder.Services.AddDbContext<AppDBContext>(options => options.UseInMemoryDatabase("un2data"));
builder.Services.AddSqlite<AppDBContext>(connectString);

var app = builder.Build();
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
app.UseSwagger();

app.MapGet("/", () => "Hello World!");

app.MapGet("/Usuarios", async (AppDBContext dbContext) => await dbContext.Usuarios.ToListAsync());

app.MapGet("/Usuario/{id}", async (int id, AppDBContext dbContext) =>
        await dbContext.Usuarios.FirstOrDefaultAsync(a => a.Id == id));

app.MapPost("/Usuario", async (Usuario usuario, AppDBContext dbContext) =>
{
    dbContext.Usuarios.Add(usuario);
    await dbContext.SaveChangesAsync();
    return usuario;
});

app.MapPut("/Usuario/{id}", async (int id, Usuario cliente, AppDBContext dbContext) =>
{
    dbContext.Entry(cliente).State = EntityState.Modified;
    await dbContext.SaveChangesAsync();
    return cliente;
});

app.MapDelete("/Usuario/{id}", async (int id, AppDBContext dbContext) =>
{
    var cliente = await dbContext.Usuarios.FirstOrDefaultAsync(a => a.Id == id);
    if (cliente != null)
    {
        dbContext.Remove(cliente);
        await dbContext.SaveChangesAsync();
    }
    return;
});

app.MapGet("/Projetos", async (AppDBContext dbContext) => await dbContext.Projetos.ToListAsync());
app.MapGet("/Projeto/{id}", async (int id, AppDBContext dbContext) =>
        await dbContext.Projetos.FirstOrDefaultAsync(a => a.Id == id));

app.MapPost("/Projeto", async (Projeto projeto, AppDBContext dbContext) =>
{
    dbContext.Projetos.Add(projeto);
    await dbContext.SaveChangesAsync();
    return projeto;
});

app.MapPut("/Projeto/{id}", async (int id, Projeto projeto, AppDBContext dbContext) =>
{
    dbContext.Entry(projeto).State = EntityState.Modified;
    await dbContext.SaveChangesAsync();
    return projeto;
});

app.MapDelete("/Projeto/{id}", async (int id, AppDBContext dbContext) =>
{
    var projeto = await dbContext.Projetos.FirstOrDefaultAsync(a => a.Id == id);
    if (projeto != null)
    {
        dbContext.Remove(projeto);
        await dbContext.SaveChangesAsync();
    }
    return;
});

app.MapGet("/Tarefas", async (AppDBContext dbContext) => await dbContext.Tarefas.Include(x => x.Usuario).ToListAsync());

app.MapGet("/Tarefas/{id}", async (int id, AppDBContext dbContext) =>
        await dbContext.Tarefas.Include(x => x.Usuario).Where(a => a.ProjetoId == id).ToListAsync());

app.MapGet("/Tarefa/{id}", async (int id, AppDBContext dbContext) =>
        await dbContext.Tarefas.Include(x=>x.Usuario).FirstOrDefaultAsync(a => a.Id == id));

app.MapPost("/Tarefa", async (Tarefa tarefa, AppDBContext dbContext) =>
{

    dbContext.Tarefas.Add(tarefa);
    await dbContext.SaveChangesAsync();
    var novatarefa = await dbContext.Tarefas.Include(x => x.Usuario).FirstOrDefaultAsync(a => a.Id == tarefa.Id);
    return novatarefa;
});

app.MapPut("/Tarefa/{id}", async (int id, Tarefa tarefa, AppDBContext dbContext) =>
{
    dbContext.Entry(tarefa).State = EntityState.Modified;
    await dbContext.SaveChangesAsync();
    return tarefa;
});

app.MapDelete("/Tarefa/{id}", async (int id, AppDBContext dbContext) =>
{
    var tarefa = await dbContext.Tarefas.FirstOrDefaultAsync(a => a.Id == id);
    if (tarefa != null)
    {
        dbContext.Remove(tarefa);
        await dbContext.SaveChangesAsync();
    }
    return;
});


app.UseSwaggerUI();
app.Run();


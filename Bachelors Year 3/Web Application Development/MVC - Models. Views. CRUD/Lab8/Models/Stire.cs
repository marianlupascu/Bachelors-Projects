using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Lab8.Models
{
    public class Stire
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Camp obigatoriu")][MaxLength(50, ErrorMessage = "Lungimea tre sa fie min 50")]
        public string Titlu { get; set; }
        [Required][MinLength(30)]
        public string Continut { get; set; }
        [Required]
        public DateTime Data { get; set; }
        public int IdCategorie { get; set; }
        [Required]
        public virtual Categorie Categorie { get; set; }
        public IEnumerable<SelectListItem> Categories { get; set; }
    }

    public class StireDBContext : DbContext
    {
        public StireDBContext() : base("DBConnectionString") { }
        public DbSet<Stire> Stiri { get; set; }
        public DbSet<Categorie> Categorii { get; set; }
    }

}
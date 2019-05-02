using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Web;

namespace Lab8.Models
{
    public class Categorie
    {
        [Key]
        public int Id { get; set; }
        public string Nume { get; set; }
        public virtual ICollection<Stire> Stiri { get; set; }
    }

}
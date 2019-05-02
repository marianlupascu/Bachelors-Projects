using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Lab10.Models
{
    public class Student
    {
        [Key]
        public int StudentId { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Prenume { get; set; }
        [Required][MinLength(13)][MaxLength(13)]
        public string CNP { get; set; }
        public DateTime DataNastere { get; set; }
        public int AnStudiu { get; set; }
    }

}
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Lab8.Models;

namespace Lab8.Controllers
{
    public class CategorieController : Controller
    {
        // GET: Categorie
        private StireDBContext db = new StireDBContext();
        public ActionResult Index()
        {
            var categorii = from categorie in db.Categorii
                orderby categorie.Nume
                select categorie;
            ViewBag.Categorii = categorii;
            return View();
        }

        public ActionResult Show(int id)
        {
            Categorie categorie = db.Categorii.Find(id);
            ViewBag.Categorie = categorie;
            return View();
        }

        public ActionResult New()
        {
            return View();
        }

        [HttpPost]
        public ActionResult New(Categorie categorie)
        {
            try
            {
                db.Categorii.Add(categorie);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception e)
            {
                return View();
            }
        }

        public ActionResult Edit(int id)
        {
            Categorie categorie = db.Categorii.Find(id);
            ViewBag.Categorie = categorie;
            return View();
        }


        [HttpPut]
        public ActionResult Edit(int id, Categorie requestCategorie)
        {
            try
            {
                Categorie categorie = db.Categorii.Find(id);
                if (TryUpdateModel(categorie))
                {
                    if (categorie != null)
                    {
                        ICollection<Stire> stiri = categorie.Stiri;
                        categorie.Nume = requestCategorie.Nume;

                        foreach (var stire in stiri)
                        {
                            stire.Categorie = categorie;
                        }
                    }

                    db.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            catch (Exception e)
            {
                return View();
            }
        }
        [HttpDelete]
        public ActionResult Delete(int id)
        {
            Categorie categorie = db.Categorii.Find(id);

            db.Categorii.Remove(categorie ?? throw new InvalidOperationException());
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
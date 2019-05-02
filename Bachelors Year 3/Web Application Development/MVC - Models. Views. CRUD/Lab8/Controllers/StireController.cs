using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Lab8.Models;

namespace Lab8.Controllers
{
    public class StireController : Controller
    {
        // GET: Stire
        private StireDBContext db = new StireDBContext();
        public ActionResult Index()
        {
            var stiri = from stire in db.Stiri
                        orderby stire.Titlu
                select stire;
            ViewBag.Stiri = stiri;
            ViewBag.Categorii = db.Categorii;
            return View();
        }

        public ActionResult Show(int id)
        {
            Stire stire = db.Stiri.Find(id);
            return View(stire);
        }
        public ActionResult New()
        {
            Stire stire = new Stire();
            stire.Categories = GetAllCategories();
            ViewBag.Categorii = db.Categorii;
            return View(stire);
        }
        
        [NonAction]
        private IEnumerable<SelectListItem> GetAllCategories()
        {
            // generam o lista goala
            var selectList = new List<SelectListItem>();
            // Extragem toate categoriile din baza de date
            var categories = from cat in db.Categorii select cat;
            // iteram prin categorii
            foreach (var category in categories)
            {
                // Adaugam in lista elementele necesare pentru dropdown
                selectList.Add(new SelectListItem
                {
                    Value = category.Id.ToString(),
                    Text = category.Nume
                });
            }
            // returnam lista de categorii
            return selectList;

        }

        [HttpPost]
        public ActionResult New(Stire stire)
        {
            try
            {
                ViewBag.Categorii = db.Categorii;
                if (ModelState.IsValid)
                {
                    db.Stiri.Add(stire);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }

                return View();
            }
            catch (Exception e)
            {
                return View();
            }
        }

        public ActionResult Edit(int id)
        {
            Stire stire = db.Stiri.Find(id);
            ViewBag.Categorii = db.Categorii;
            return View(stire);
        }


        [HttpPut]
        public ActionResult Edit(int id, Stire requestStire)
        {
            try
            {
                Stire stire = db.Stiri.Find(id);
                if (TryUpdateModel(stire))
                {
                    if (stire != null)
                    {
                        db.Categorii.Find(stire.IdCategorie)?.Stiri.Remove(stire);

                        stire.Titlu = requestStire.Titlu;
                        stire.Continut = requestStire.Continut;
                        stire.Data = requestStire.Data;
                        stire.IdCategorie = requestStire.IdCategorie;
                        stire.Categorie = db.Categorii.Find(requestStire.IdCategorie);

                        db.Categorii.Find(stire.IdCategorie)?.Stiri.Add(stire);
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
            Stire stire = db.Stiri.Find(id);
            db.Stiri.Remove(stire ?? throw new InvalidOperationException());
            db.SaveChanges();
            return RedirectToAction("Index");
        }


    }
}
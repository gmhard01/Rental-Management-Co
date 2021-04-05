﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Models
{
    public class Property
    {
        public int PropertyId { get; set; }
        public string Title { get; set; }
        public int AddressId { get; set; }
        public decimal RentAmount { get; set; }
        public int NumberOfBeds { get; set; }
        public decimal NumberOfBaths { get; set; }
        public int LandlordId { get; set; }
        public string Picture { get; set; }
        public bool Available { get; set; }
        public DateTime AvailableDate { get; set; }
        public string PropertyDescription { get; set; }
    }
}
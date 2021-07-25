namespace EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class WGCartItem
    {
        [Key]
        [StringLength(100)]
        public string ItemID { get; set; }

        [Required]
        [StringLength(100)]
        public string CartID { get; set; }

        public int Quantity { get; set; }

        public DateTime DateCreated { get; set; }

        public int WGProductID { get; set; }

        public virtual WGProduct WGProduct { get; set; }
    }
}

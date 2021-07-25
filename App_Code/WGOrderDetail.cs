namespace EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class WGOrderDetail
    {
        [Key]
        public int WGOrderDetailID { get; set; }

        public int WGOrderID { get; set; }

        public int WGProductID { get; set; }

        [Column(TypeName = "money")]
        public decimal Price { get; set; }

        public int Quantity { get; set; }

        public string Username { get; set; }

        public virtual WGOrder WGOrder { get; set; }

        public virtual WGProduct WGProduct { get; set; }
    }
}

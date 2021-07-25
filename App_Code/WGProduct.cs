namespace EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class WGProduct
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public WGProduct()
        {
            WGCartItems = new HashSet<WGCartItem>();
            WGOrderDetails = new HashSet<WGOrderDetail>();
        }

        public int WGProductID { get; set; }

        [Required]
        [StringLength(250)]
        public string Name { get; set; }

        public string Description { get; set; }

        [Column(TypeName = "money")]
        public decimal Price { get; set; }

        [StringLength(100)]
        public string Image { get; set; }

        public DateTime LastUpdated { get; set; }

        public int WGCategoryID { get; set; }

        public int WGProductStatusID { get; set; }

        public int WGVendorID { get; set; }

        [StringLength(100)]
        public string Image2 { get; set; }

        [StringLength(100)]
        public string Thumbnail { get; set; }

        public bool Discounted { get; set; }

        [StringLength(100)]
        public string Thumbnail2 { get; set; }

        public int? QtyAvailable { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<WGCartItem> WGCartItems { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<WGOrderDetail> WGOrderDetails { get; set; }
    }
}

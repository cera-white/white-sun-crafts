namespace EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class WGOrder
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public WGOrder()
        {
            WGOrderDetails = new HashSet<WGOrderDetail>();
        }

        public int WGOrderID { get; set; }

        public string Username { get; set; }

        public DateTime? OrderDate { get; set; }

        [StringLength(100)]
        public string FirstName { get; set; }

        [StringLength(100)]
        public string LastName { get; set; }

        [StringLength(150)]
        public string ShipAddress { get; set; }

        [StringLength(100)]
        public string ShipCity { get; set; }

        [StringLength(100)]
        public string ShipRegion { get; set; }

        [StringLength(20)]
        public string ShipPostalCode { get; set; }

        [StringLength(100)]
        public string ShipCountry { get; set; }

        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }

        public bool HasBeenShipped { get; set; }

        public DateTime? ShippedDate { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<WGOrderDetail> WGOrderDetails { get; set; }
    }
}

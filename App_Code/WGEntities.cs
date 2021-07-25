namespace EF
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class WGEntities : DbContext
    {
        public WGEntities()
            : base("name=WGEntities")
        {
        }

        public virtual DbSet<WGCartItem> WGCartItems { get; set; }
        public virtual DbSet<WGOrderDetail> WGOrderDetails { get; set; }
        public virtual DbSet<WGOrder> WGOrders { get; set; }
        public virtual DbSet<WGProduct> WGProducts { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<WGCartItem>()
                .Property(e => e.ItemID)
                .IsUnicode(false);

            modelBuilder.Entity<WGCartItem>()
                .Property(e => e.CartID)
                .IsUnicode(false);

            modelBuilder.Entity<WGOrderDetail>()
                .Property(e => e.Price)
                .HasPrecision(19, 4);

            modelBuilder.Entity<WGOrder>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<WGOrder>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<WGOrder>()
                .Property(e => e.ShipAddress)
                .IsUnicode(false);

            modelBuilder.Entity<WGOrder>()
                .Property(e => e.ShipCity)
                .IsUnicode(false);

            modelBuilder.Entity<WGOrder>()
                .Property(e => e.ShipRegion)
                .IsUnicode(false);

            modelBuilder.Entity<WGOrder>()
                .Property(e => e.ShipPostalCode)
                .IsUnicode(false);

            modelBuilder.Entity<WGOrder>()
                .HasMany(e => e.WGOrderDetails)
                .WithRequired(e => e.WGOrder)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<WGProduct>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<WGProduct>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<WGProduct>()
                .Property(e => e.Price)
                .HasPrecision(19, 4);

            modelBuilder.Entity<WGProduct>()
                .Property(e => e.Image)
                .IsUnicode(false);

            modelBuilder.Entity<WGProduct>()
                .Property(e => e.Image2)
                .IsUnicode(false);

            modelBuilder.Entity<WGProduct>()
                .Property(e => e.Thumbnail)
                .IsUnicode(false);

            modelBuilder.Entity<WGProduct>()
                .Property(e => e.Thumbnail2)
                .IsUnicode(false);

            modelBuilder.Entity<WGProduct>()
                .HasMany(e => e.WGCartItems)
                .WithRequired(e => e.WGProduct)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<WGProduct>()
                .HasMany(e => e.WGOrderDetails)
                .WithRequired(e => e.WGProduct)
                .WillCascadeOnDelete(false);
        }
    }
}

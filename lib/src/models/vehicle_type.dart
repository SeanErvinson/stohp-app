class VehicleType {
  final int id;
  final String name;
  final String code;

  VehicleType(this.id, this.name, this.code);

  static VehicleType parseVehicleType(String code) {
    for (var vehicleType in getVehicleTypes()) {
      if (vehicleType.code == code) return vehicleType;
    }
    return getVehicleTypes()[0];
  }

  static List<VehicleType> getVehicleTypes() {
    return <VehicleType>[
      VehicleType(1, "UV Express", "U"),
      VehicleType(2, "Bus", "B"),
      VehicleType(3, "Jeep", "J")
    ];
  }
}

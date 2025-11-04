// create_admin_hash.js
const bcrypt = require("bcrypt"); // or 'bcrypt' if you prefer
const fs = require("fs");

(async () => {
  const pwd = process.argv[2] || "ChangeMe@123";
  const hash = await bcrypt.hash(pwd, 10);
  console.log("Plain password:", pwd);
  console.log("Bcrypt hash:", hash);
  // optionally write hash to file
  fs.writeFileSync("new_admin_hash.txt", `password=${pwd}\nhash=${hash}\n`);
})();
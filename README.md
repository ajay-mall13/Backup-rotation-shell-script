
# 🛡️ Automated Backup Script with Retention Policy

This Bash script automatically creates a compressed (`.zip`) backup of a given source directory and retains only the latest 5 backups by deleting older ones.

---

## 📂 Features

- ✅ Zip compression of a source folder
- 🕒 Timestamp-based backup naming
- 🧹 Rotation policy: keeps only the latest **5 backups**
- 🔁 Suitable for automation via **cron jobs**

---

## 🛠️ Usage

```bash
./backup.sh <path to your source directory> <path to your backup folder>
```

**Example**:

```bash
./backup.sh /home/ubuntu/devops /home/ubuntu/backups
```

---

## 📦 Backup Output

Backups are stored in the format:

```
backups_YYYY-MM-DD_HH-MM-SS.zip
```

e.g., `backups_2025-06-20_10-45-30.zip`

---

## 🔄 Rotation Logic

If there are **more than 5** backups in the backup folder, the oldest ones are automatically deleted to retain only the 5 most recent.

---

## 🕰️ Setup Automated Backups via Crontab

1. Open crontab:

```bash
crontab -e
```

2. Add the following line to schedule daily backups at every minute:

```bash
* * * * * /bin/bash /path/to/backup.sh /path/to/source /path/to/backup_folder
```
![Screenshot 2025-06-20 120922](https://github.com/user-attachments/assets/aa416d3e-cfae-40e7-89c3-9b8b0a134e21)

3. Save and exit.

---

## 📝 Notes

- Make sure the script has execution permission:

```bash
chmod 764 backup.sh
```

- Ensure `zip` is installed:

```bash
sudo apt install zip -y   # Debian/Ubuntu systems
```

---

## 📁 Example Directory Structure

```
.
├── backup.sh
└── backups/
    ├── backups_2025-06-20_10-45-30.zip
    ├── backups_2025-06-19_10-45-30.zip
    └── ...
```

---

## 👨‍💻 Author

Ajay Mall — *Automated backup shell script for Linux*

#!/usr/bin/env bash
# تشغيل على Render: يثبت الحزم ثم يربط gunicorn على PORT (يصلح إذا تعطّل خطوة Build)
set -euo pipefail
cd "$(dirname "$0")"
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
exec python -m gunicorn --bind "0.0.0.0:${PORT}" app:app

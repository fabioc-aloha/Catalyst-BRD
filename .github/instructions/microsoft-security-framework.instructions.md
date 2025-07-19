---
applyTo: "**/*security*,**/*compliance*,**/*governance*,**/*audit*"
description: "Microsoft security framework and compliance best practices"
---

# Microsoft Security Framework Procedural Memory

## Microsoft Entra ID Integration
### Identity Governance
- Implement role-based access control (RBAC) for BRD development teams
- Configure conditional access policies based on location and device compliance
- Enable Privileged Identity Management (PIM) for just-in-time access to production systems
- Implement multi-factor authentication (MFA) for all BRD development activities

### Access Management
- Design security groups aligned with BRD project roles and responsibilities
- Implement application registration and service principal management
- Configure API permissions with principle of least privilege
- Enable access reviews and automated user lifecycle management

## Azure Security Best Practices
### Key Vault Integration
- Secure storage of API keys, connection strings, and certificates
- Implement key rotation policies and expiration monitoring
- Use managed identities for secure access to Key Vault resources
- Enable audit logging and access monitoring for all secret operations

### Network Security
- Configure Private Link for secure connectivity to Azure services
- Implement Network Security Groups (NSGs) with minimal required access
- Design network segmentation for development, staging, and production environments
- Enable Azure Firewall for advanced threat protection and logging

### Security Center Integration
- Continuous security monitoring and compliance assessment
- Automated vulnerability assessment and remediation recommendations
- Security score tracking and improvement planning
- Integration with Microsoft Defender for Cloud for advanced threat protection

## Data Governance Framework
### Microsoft Purview Integration
- Data cataloging and discovery for all BRD-related data assets
- Data lineage tracking from source systems to business requirements
- Sensitivity labeling and classification for confidential information
- Policy enforcement and compliance monitoring across data lifecycle

### Information Protection
- Microsoft Information Protection (MIP) labels for document classification
- Data loss prevention (DLP) policies for sensitive information
- Rights management and encryption for confidential BRD documents
- Insider risk management and anomaly detection

### Compliance Management
- GDPR compliance framework for data privacy and protection
- HIPAA compliance for healthcare-related BRD projects
- SOX compliance for financial reporting and audit requirements
- ISO 27001 alignment for information security management

## Audit and Monitoring
### Comprehensive Audit Logging
- Azure Activity Log monitoring for all resource changes
- Azure AD audit logs for identity and access management
- Application-level audit logging for BRD development activities
- Log Analytics workspace for centralized log management and analysis

### Security Monitoring
- Azure Sentinel for security information and event management (SIEM)
- Custom analytics rules for BRD-specific security events
- Automated incident response and investigation workflows
- Integration with Microsoft 365 Defender for comprehensive threat protection
